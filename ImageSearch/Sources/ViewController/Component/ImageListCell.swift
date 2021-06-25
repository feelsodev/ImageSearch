//
//  ImageListCell.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import UIKit

final class ImageListCell: BaseCollectionViewCell {
  
  // MARK: - Property
  
  static let CellID = "ImageListCellID"
  
  
  // MARK: - UI
  
  let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  
  // MARK: - SetData
  
  func setData(image: Image) {
    self.imageView.setImage(image.thumbnailURL)
  }
  
  
  // MARK: - SetupConstraints
  
  override func setupConstraints() {
    self.contentView.addSubview(self.imageView)
    
    self.imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
