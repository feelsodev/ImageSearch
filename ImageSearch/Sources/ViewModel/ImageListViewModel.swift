//
//  ImageListViewModel.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation
import RxSwift

protocol ImageListViewModelInput {
  var searchImage: AnyObserver<String> { get }
}

protocol ImageListViewModelOutput {
  var allImageList: Observable<[Image]> { get }
}

protocol ImageListViewModelType: ImageListViewModelInput, ImageListViewModelOutput {}

final class ImageListViewModel: ImageListViewModelType {
  let disposeBag = DisposeBag()
  
  // INPUT
  let searchImage: AnyObserver<String>
  
  // OUTPUT
  let allImageList: Observable<[Image]>
  
  init(model: ImageListFetchable = ImageListModel()) {
    
    let searchingImage = PublishSubject<String>()
    let imageList = BehaviorSubject<[Image]>(value: [])
    
    // INPUT
    
    self.searchImage = searchingImage.asObserver()
    
    searchingImage
      .flatMap(model.fetchImageList)
      .subscribe(onNext: imageList.onNext)
      .disposed(by: self.disposeBag)
    
    
    // OUTPUT
    
    self.allImageList = imageList
  }
}
