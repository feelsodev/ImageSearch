//
//  Document.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation

struct Image: Codable {
  let collection, datetime: String
  let displaySitename: String
  let docURL: String
  let imageURL: String
  let thumbnailURL: String
  let height: Int
  let width: Int
  
  enum CodingKeys: String, CodingKey {
    case collection, datetime
    case displaySitename = "display_sitename"
    case docURL = "doc_url"
    case imageURL = "image_url"
    case thumbnailURL = "thumbnail_url"
    case height
    case width
  }
}
