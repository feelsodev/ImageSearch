//
//  UICollectionView+Ext.swift
//  ImageSearch
//
//  Created by once on 2021/06/24.
//

import UIKit

extension UICollectionView {
  func setDescriptView(type: DescriptState) {
    type.descriptView.frame = CGRect(x: self.center.x,
                                     y: self.center.y,
                                     width: self.bounds.size.width,
                                     height: self.bounds.size.height)
    self.backgroundView = type.descriptView
  }
}
