//
//  ImageListModel.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//
import Foundation
import RxSwift

protocol ImageListFetchable: AnyObject {
  func propertyReste()
  func fetchImageList(param: String) -> Observable<[Image]>
  func nextPageImageList() -> Observable<[Image]>
}

final class ImageListModel: ImageListFetchable {
  let repository: NetworkServiceType
  private var pageState: Int = 1
  private var paramState: String = ""
  
  init(repository: NetworkServiceType = NetworkService()) {
    self.repository = repository
  }
  
  func fetchImageList(param: String) -> Observable<[Image]> {
    self.paramState = param
    self.pageState = 1
    
    return self.repository.getImageListRx(param: param, page: self.pageState)
      .map { data in
        guard let response = try? JSONDecoder().decode(Items.self, from: data) else {
          throw NSError(domain: "Fetch Image Decoding error", code: -1, userInfo: nil)
        }
        
        return response.items
      }
  }
  
  func nextPageImageList() -> Observable<[Image]> {
    self.pageState += 1

    return self.repository.getImageListRx(param: self.paramState, page: self.pageState)
      .map { data in
        guard let response = try? JSONDecoder().decode(Items.self, from: data) else {
          throw NSError(domain: "Next page Decoding error", code: -1, userInfo: nil)
        }
        
        return response.items
      }
  }
  
  func propertyReste() {
    self.pageState = 1
    self.paramState = ""
  }
}
