//
//  ImageListModel.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//
import Foundation
import RxSwift

protocol ImageListFetchable: AnyObject {
  func fetchImageList(page: Int, param: String) -> Observable<Result<Items, NetworkError>>
}

final class ImageListModel: ImageListFetchable {
  let repository: NetworkServiceType
  
  init(repository: NetworkServiceType = NetworkService()) {
    self.repository = repository
  }
  
  func fetchImageList(page: Int, param: String) -> Observable<Result<Items, NetworkError>> {
    return self.repository.getImageListRx(param: param, page: page)
  }
}
