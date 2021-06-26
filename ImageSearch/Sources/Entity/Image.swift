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
  let height, width: Int
  
  enum CodingKeys: String, CodingKey {
    case datetime
    case displaySitename = "display_sitename"
    case imageURL = "image_url"
    case thumbnailURL = "thumbnail_url"
    case height, width
  }
}

extension Image: Equatable {
  static func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.datetime == rhs.datetime
      && lhs.displaySitename == rhs.displaySitename
      && lhs.imageURL == rhs.imageURL
      && lhs.thumbnailURL == rhs.thumbnailURL
      && lhs.width == rhs.width
      && lhs.height == rhs.height
  }
}
