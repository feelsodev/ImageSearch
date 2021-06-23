//
//  ImageListViewModel.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation
import RxSwift
import RxRelay

protocol ImageListViewModelInput {
  var searchImage: AnyObserver<String> { get }
  var nextPageImage: AnyObserver<Void> { get }
  var searchEmptyState: AnyObserver<Bool> { get }
}

protocol ImageListViewModelOutput {
  var allImageList: Observable<[Image]> { get }
  var imageListCellState: Observable<Bool> { get }
  var loadingState: Observable<Bool> { get }
}

protocol ImageListViewModelType: ImageListViewModelInput, ImageListViewModelOutput {}

final class ImageListViewModel: ImageListViewModelType {
  let disposeBag = DisposeBag()
  
  // INPUT
  let searchImage: AnyObserver<String>
  let nextPageImage: AnyObserver<Void>
  let searchEmptyState: AnyObserver<Bool>
  
  // OUTPUT
  let allImageList: Observable<[Image]>
  let imageListCellState: Observable<Bool>
  let loadingState: Observable<Bool>
  
  init(model: ImageListFetchable = ImageListModel()) {
    
    let searchingImage = PublishSubject<String>()
    let nextPageImage = PublishSubject<Void>()
    let emptyState = PublishSubject<Bool>()
    
    let imageList = BehaviorRelay<[Image]>(value: [])
    let imageListShowing = BehaviorSubject<Bool>(value: false)
    let loading = PublishRelay<Bool>()
    
    // INPUT
    
    self.searchImage = searchingImage.asObserver()
    
    searchingImage
      .filter { !$0.isEmpty }
      .flatMap(model.fetchImageList)
      .subscribe(onNext: { image in
        imageList.accept(image)
        imageListShowing.onNext(false)
      })
      .disposed(by: self.disposeBag)
    
    self.nextPageImage = nextPageImage.asObserver()
    
    nextPageImage
      .skip(1)
      .flatMap(model.nextPageImageList)
      .subscribe(onNext: { image in
        imageList.accept(imageList.value + image)
        loading.accept(true)
      })
      .disposed(by: self.disposeBag)
    
    self.searchEmptyState = emptyState.asObserver()
    
    emptyState
      .subscribe(onNext: { state in
        if state {
          model.propertyReste()
          imageList.accept([])
        }
        loading.accept(state)
        imageListShowing.onNext(state)
      })
      .disposed(by: self.disposeBag)
    
    // OUTPUT
    
    self.allImageList = imageList.asObservable()
    self.imageListCellState = imageListShowing.asObservable()
    self.loadingState = loading.asObservable()
  }
}
