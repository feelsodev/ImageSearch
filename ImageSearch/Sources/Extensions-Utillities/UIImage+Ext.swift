//
//  UIImage+Ext.swift
//  ImageSearch
//
//  Created by once on 2021/06/24.
//

import UIKit

extension UIImage {
  func setSFSymbols(systemName: String, weight: SymbolWeight) -> UIImage {
    guard let image = UIImage(systemName: systemName)?
            .withConfiguration(UIImage.SymbolConfiguration(weight: weight)) else { return UIImage() }
    return image
  }
}
