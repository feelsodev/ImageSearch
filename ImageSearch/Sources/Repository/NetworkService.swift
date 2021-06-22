//
//  NetworkService.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation
import RxSwift

protocol NetworkServiceType {
  func getImageListRx(param: String) -> Observable<Data>
}

class NetworkService: NetworkServiceType {
  func getImageListRx(param: String) -> Observable<Data> {
    return Observable.create { observer in
      self.getImageList(paramData: param) { result in
        switch result {
        case let .success(data):
          observer.onNext(data)
          observer.onCompleted()
        case let .failure(error):
          observer.onError(error)
        }
      }
      return Disposables.create()
    }
  }
}

extension NetworkService {
  private func getImageList(paramData: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
    let param = ["query": paramData]
    
    NetworkManager
      .shared
      .session
      .request(NetworkRouter.searchImage(params: param))
      .responseData { response in
        switch response.result {
        case let .success(data):
          onComplete(.success(data))
        case let .failure(error):
          onComplete(.failure(error))
        }
      }
  }
}
