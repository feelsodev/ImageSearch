//
//  BaseCollectionViewCell.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
  // MARK: - Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.initialize()
    self.setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Override point
  func initialize() {
    
  }
  
  // Override point
  func setupConstraints() {
    
  }
}
