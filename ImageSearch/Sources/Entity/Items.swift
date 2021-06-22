//
//  Image.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation

struct Items: Codable {
  let items: [Image]
  let meta: Meta
  
  enum CodingKeys: String, CodingKey {
    case items = "documents"
    case meta
  }
}
