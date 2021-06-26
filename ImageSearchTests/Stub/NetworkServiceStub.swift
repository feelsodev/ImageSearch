//
//  NetworkServiceStub.swift
//  ImageSearchTests
//
//  Created by once on 2021/06/26.
//

import Foundation
import RxSwift

@testable import ImageSearch

class NetworkServiceStub: NetworkServiceType {
  func getImageListRx(param: String, page: Int) -> Observable<Result<Items, NetworkError>> {
    return self.getImageListStub()
  }
  
  private func getImageListStub() -> Observable<Result<Items, NetworkError>> {
    let data = ImageDummyData.imageJSONString.data(using: .utf8)!
    do {
      let result = try JSONDecoder().decode(Items.self, from: data)
      return .just(.success(result))
    } catch {
      return .just(.failure(.defaultError))
    }
  }
}
