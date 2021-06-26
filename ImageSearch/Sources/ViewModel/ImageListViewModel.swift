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
import RxOptional

protocol ImageListViewModelInput {
  var searchImage: AnyObserver<String> { get }
  var nextPageImage: AnyObserver<Void> { get }
  var searchEmptyState: AnyObserver<Bool> { get }
}

protocol ImageListViewModelOutput {
  var allImageList: Observable<[Image]> { get }
  var loadingState: Observable<LoadingState> { get }
  var cellBackgroundState: Observable<DescriptState> { get }
  var errorMessage: Observable<String> { get }
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
  let cellBackgroundState: Observable<DescriptState>
  let errorMessage: Observable<String>
  
  init(model: ImageListFetchable = ImageListModel()) {
    
    let searchingImage = PublishSubject<String>()
    let nextPageImage = PublishSubject<Void>()
    let emptyState = PublishSubject<Bool>()
    
    let imageList = BehaviorRelay<[Image]>(value: [])
    let loading = PublishRelay<LoadingState>()
    let cellBG = BehaviorRelay<DescriptState>(value: .empty)
    let errorMessageProxy = PublishSubject<String>()
      
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
      .skip(1)
      .filter { !$0.isEmpty }
      .do { _ in page.accept(1) }
      .flatMap { model.fetchImageList(page: 1, param: $0) }
      .share()
      
    imageResult
      .map { data -> [Image]? in
        guard case .success(let value) = data else {
            return nil
        }
        return value.items
      }
      .filterNil()
      .subscribe(onNext: { image in
        if image.isEmpty {
          cellBG.accept(.error)
        } else {
          cellBG.accept(.finish)
        }
        imageList.accept(image)
        loading.accept(.finish)
      })
      .disposed(by: self.disposeBag)
    
    imageResult
      .map { data -> Bool? in
        guard case .success(let value) = data else {
            return nil
        }
        return value.meta.isEnd
      }
      .filterNil()
      .bind(to: isEnd)
      .disposed(by: self.disposeBag)
    
    imageResult
      .map { data -> String? in
        guard case .failure(let error) = data else {
            return nil
        }
        return error.message
      }
      .filterNil()
      .bind(to: errorMessageProxy)
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
      .map { data -> [Image]? in
        guard case .success(let value) = data else {
            return nil
        }
        return value.items
      }
      .filterNil()
      .subscribe { image in
        imageList.accept(imageList.value + image)
      }
      .disposed(by: self.disposeBag)
    
    self.searchEmptyState = emptyState.asObserver()
    
    emptyState
      .subscribe(onNext: { state in
        imageList.accept([])
        
        if state {
          loading.accept(.empty)
          cellBG.accept(.empty)
        } else {
          loading.accept(.loading)
          cellBG.accept(.loading)
        }
      })
      .disposed(by: self.disposeBag)
    
    // OUTPUT
    
    self.allImageList = imageList.asObservable()
    self.loadingState = loading.asObservable()
    self.cellBackgroundState = cellBG.asObservable()
    self.errorMessage = errorMessageProxy.asObservable()
  }
  
  
  // MARK: - Return VC
  
  static func createForImageDetail(_ image: Image) -> UIViewController {
    let view = ImageDetailViewController()
    view.modalPresentationStyle = .fullScreen
    view.setData(image)
    return view
  }
}
