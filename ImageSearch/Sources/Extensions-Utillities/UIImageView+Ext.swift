//
//  UIImageView+Ext.swift
//  ImageSearch
//
//  Created by once on 2021/06/22.
//

import UIKit

extension UIImageView {
  func setImage(_ url: String) {
    let key = NSString(string: url)
    
    if let cached = ImageCacheManager.shared.object(forKey: key) {
      self.image = cached
    } else {
      guard let url = URL(string: url) else { return }
      DispatchQueue.global().async { [weak self] in
        guard let `self` = self else { return }
        if let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self.image = image
            ImageCacheManager.shared.setObject(image, forKey: key)
          }
        }
      }
    }
  }
}
