//
//  ImageListCell.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import UIKit

class ImageListCell: BaseCollectionViewCell {
  
  // MARK: - Property
  
  static let CellID = "CellID"
  
  
  // MARK: - UI
  
  let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  func setData(image: UIImage) {
    self.imageView.image = image
  }
  
  override func setupConstraints() {
    self.contentView.addSubview(self.imageView)
    
    self.imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
