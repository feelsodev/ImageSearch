//
//  NetworkRouter.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Alamofire

enum NetworkRouter: URLRequestConvertible {
  typealias Parameters = [String: Any]
  
  
  // MARK: - Case
  
  case searchImage(params: Parameters)
  
  
  // MARK: - URL
  
  var baseURL: URL {
    return URL(string: API.BASE_URL)!
  }
  
  
  // MARK: - Headers
  
  var headers: HTTPHeaders {
    return [
      "Authorization": API.KEY
    ]
  }
  
  // MARK: - Method
  
  var method: HTTPMethod {
    switch self {
    case .searchImage:
      return .get
    }
  }
  
  
  // MARK: - EndPoint
  
  var endPoint: String {
    switch self {
    case .searchImage:
      return "search/image"
    }
  }
  
  
  // MARK: - Parameters
  
  var parameters: Parameters? {
    switch self {
    case let .searchImage(params):
      return params
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = self.baseURL.appendingPathComponent(self.endPoint)

    var request = URLRequest(url: url)
    request.headers = self.headers
    request.method = self.method
    
    switch method {
    case .get:
      request = try URLEncoding.default.encode(request, with: self.parameters)
    case .post:
      request = try JSONEncoding.default.encode(request, with: self.parameters)
      request.setValue("application/json", forHTTPHeaderField: "Accept")
    default:
      break
    }
    return request
  }
}
