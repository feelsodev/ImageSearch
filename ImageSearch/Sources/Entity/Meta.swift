//
//  Meta.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation

struct Meta: Codable {
  let isEnd: Bool
  let pageableCount: Int
  let totalCount: Int
  
  enum CodingKeys: String, CodingKey {
    case isEnd = "is_end"
    case pageableCount = "pageable_count"
    case totalCount = "total_count"
  }
}
