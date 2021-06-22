//
//  ImageCacheManager.swift
//  ImageSearch
//
//  Created by once on 2021/06/22.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
