//
//  ImageListViewModel.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol ImageListViewModelInput {
  var searchImage: AnyObserver<String> { get }
  var nextPageImage: AnyObserver<Void> { get }
  var searchEmptyState: AnyObserver<Bool> { get }
}

protocol ImageListViewModelOutput {
  var allImageList: Observable<[Image]> { get }
  var loadingState: Observable<LoadingState> { get }
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
  let loadingState: Observable<LoadingState>
  
  init(model: ImageListFetchable = ImageListModel()) {
    
    let searchingImage = PublishSubject<String>()
    let nextPageImage = PublishSubject<Void>()
    let emptyState = PublishSubject<Bool>()
    
    let imageList = BehaviorRelay<[Image]>(value: [])
    let loading = PublishRelay<LoadingState>()
    
    // Materials
    
    let page = PublishRelay<Int>()
    let isEnd = PublishRelay<Bool>()
    let valuesForSearch = Observable
      .combineLatest(
        page,
        searchingImage
      )
      .filter { $1 != "" }
    
    // INPUT
    
    self.searchImage = searchingImage.asObserver()
    
    let imageResult = searchingImage
      .filter { !$0.isEmpty }
      .do { _ in page.accept(1) }
      .flatMap { model.fetchImageList(page: 1, param: $0) }
      .share()
      
    imageResult
      .map { $0.items }
      .subscribe(onNext: { image in
        imageList.accept(image)
        loading.accept(.finished)
      })
      .disposed(by: self.disposeBag)
    
    imageResult
      .map { $0.meta.isEnd }
      .bind(to: isEnd)
      .disposed(by: self.disposeBag)
    
    self.nextPageImage = nextPageImage.asObserver()
    
    let additionalFetchImage = Observable
      .zip(nextPageImage, isEnd)
      .filter { !$1 }
      .withLatestFrom(valuesForSearch)
      .map { (pg, key) -> (Int, String) in
        let newPage = pg + 1
        newPage >= 50 ? isEnd.accept(true) : isEnd.accept(false)
        page.accept(newPage)
        return (newPage, key)
      }
      .flatMapLatest(model.fetchImageList)
    
    additionalFetchImage
      .map { $0.items }
      .subscribe { image in
        imageList.accept(imageList.value + image)
      }
      .disposed(by: self.disposeBag)
    
    self.searchEmptyState = emptyState.asObserver()
    
    emptyState
      .subscribe(onNext: { state in
        imageList.accept([])
        
        if state {
          page.accept(1)
          loading.accept(.empty)
        } else {
          loading.accept(.loading)
        }
      })
      .disposed(by: self.disposeBag)
    
    // OUTPUT
    
    self.allImageList = imageList.asObservable()
    self.loadingState = loading.asObservable()
  }
}
