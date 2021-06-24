//
//  UIView+Ext.swift
//  ImageSearch
//
//  Created by once on 2021/06/25.
//

import UIKit
private let durationFadeAnimation: TimeInterval = 0.2

extension UIView {
  static func animateFadeOut(_ views: [UIView?], completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: durationFadeAnimation, animations: {
      views.forEach { $0?.alpha = 0 }
    }, completion: { _ in
      completion?()
    })
  }
  
  static func animateFadeIn(_ views: [UIView?], completion: (() -> Void)? = nil) {
    UIView.animate(withDuration: durationFadeAnimation, animations: {
      views.forEach { $0?.alpha = 1 }
    }, completion: { _ in
      completion?()
    })
  }
}
