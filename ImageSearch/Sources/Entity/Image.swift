//
//  Document.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation

struct Image: Codable {
  let datetime: String
  let displaySitename: String
  let imageURL: String
  let thumbnailURL: String
  
  enum CodingKeys: String, CodingKey {
    case datetime
    case displaySitename = "display_sitename"
    case imageURL = "image_url"
    case thumbnailURL = "thumbnail_url"
  }
}
