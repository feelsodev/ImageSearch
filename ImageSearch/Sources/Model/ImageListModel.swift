//
//  ImageListModel.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//
import Foundation
import RxSwift

protocol ImageListFetchable: AnyObject {
  func fetchImageList(page: Int, param: String) -> Observable<Items>
}

final class ImageListModel: ImageListFetchable {
  let repository: NetworkServiceType
  
  init(repository: NetworkServiceType = NetworkService()) {
    self.repository = repository
  }
  
  func fetchImageList(page: Int, param: String) -> Observable<Items> {

    return self.repository.getImageListRx(param: param, page: page)
      .map { data in
        guard let response = try? JSONDecoder().decode(Items.self, from: data) else {
          throw NSError(domain: "Fetch Image Decoding error", code: -1, userInfo: nil)
        }
        return response
      }
  }
}
