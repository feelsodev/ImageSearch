//
//  NetworkError.swift
//  ImageSearch
//
//  Created by once on 2021/06/25.
//

import Foundation

enum NetworkError: Error {
  case error(String)
  case defaultError
  
  var message: String? {
    switch self {
    case let .error(msg):
      return msg
    case .defaultError:
      return "잠시 후에 다시 시도해주세요."
    }
  }
}
