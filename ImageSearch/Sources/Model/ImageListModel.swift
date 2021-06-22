//
//  ImageListModel.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//
import Foundation
import RxSwift

protocol ImageListFetchable: AnyObject {
  func fetchImageList(param: String) -> Observable<[Image]>
}

class ImageListModel: ImageListFetchable {
  let repository: NetworkServiceType
  
  init(repository: NetworkServiceType = NetworkService()) {
    self.repository = repository
  }
  
  func fetchImageList(param: String) -> Observable<[Image]> {
    return self.repository.getImageListRx(param: param)
      .map { data in
        guard let response = try? JSONDecoder().decode(Items.self, from: data) else {
          throw NSError(domain: "Decoding error", code: -1, userInfo: nil)
        }
        
        return response.items
      }
  }
}
