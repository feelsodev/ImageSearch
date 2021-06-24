//
//  DescriptView.swift
//  ImageSearch
//
//  Created by once on 2021/06/24.
//

import UIKit

class DescriptView: UIView {
  let descriptImageView = UIImageView().then {
    $0.tintColor = .systemGray3
    $0.contentMode = .scaleAspectFill
  }
  let descriptLabel = UILabel().then {
    $0.font = UIFont(name: "Apple SD Gothic Neo Regular", size: 30)
    $0.textColor = .systemGray3
  }
  
  init() {
    super.init(frame: CGRect.zero)
    self.setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraints() {
    self.addSubview(self.descriptImageView)
    self.addSubview(self.descriptLabel)
    
    self.descriptImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(self.snp.centerY).offset(-100)
      $0.width.equalTo(self.snp.width).dividedBy(3)
    }
    
    self.descriptLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(self.descriptImageView.snp.bottom).offset(70)
    }
  }
}
