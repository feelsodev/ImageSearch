//
//  NetworkService.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation
import RxSwift

protocol NetworkServiceType {
  func getImageListRx(param: String, page: Int) -> Observable<Result<Items, NetworkError>>
}

final class NetworkService: NetworkServiceType {
  func getImageListRx(param: String, page: Int) -> Observable<Result<Items, NetworkError>> {
    return Observable.create { observer in
      self.getImageList(paramData: param, page: page) { result in
        observer.onNext(result)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}

extension NetworkService {
  private func getImageList(paramData: String, page: Int, onComplete: @escaping (Result<Items, NetworkError>) -> Void) {
    let param: [String: Any] = [
      "query": paramData,
      "page": page,
      "size": 30
    ]
    
    NetworkManager
      .shared
      .session
      .request(NetworkRouter.searchImage(params: param))
      .responseData { response in
        switch response.result {
        case let .success(data):
          do {
            let result = try JSONDecoder().decode(Items.self, from: data)
            onComplete(.success(result))
          } catch {
            onComplete(.failure(.defaultError))
          }
        case .failure:
          onComplete(.failure(.defaultError))
        }
      }
  }
}
