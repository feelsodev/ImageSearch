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
  
  func setData(image: Image) {
    self.imageView.setImage(image.thumbnailURL)
  }
  
  override func setupConstraints() {
    self.contentView.addSubview(self.imageView)
    
    self.imageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
