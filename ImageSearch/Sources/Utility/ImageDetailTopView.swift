//
//  ImageDetailTopView.swift
//  ImageSearch
//
//  Created by once on 2021/06/25.
//

import UIKit

class ImageDetailTopView: UIView {
  
  // MARK: - UI
  
  let backButton = UIButton().then {
    $0.tintColor = .systemBlue
    $0.setImage(UIImage().setSFSymbols(systemName: "xmark",
                                       weight: .regular), for: .normal)
  }
  
  
  // MARK: - Initialize
  
  init() {
    super.init(frame: CGRect.zero)
    self.backgroundColor = .systemGray2
    self.setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraints() {
    self.addSubview(self.backButton)
    
    self.backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(10)
      $0.bottom.equalToSuperview().offset(-10)
      $0.width.height.equalTo(20)
    }
  }
}
