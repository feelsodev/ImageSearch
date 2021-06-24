//
//  ImageDetailBottomView.swift
//  ImageSearch
//
//  Created by once on 2021/06/25.
//

import UIKit

class ImageDetailBottomView: UIView {
  
  // MARK: - UI
  
  let displaySiteNameLabel = UILabel().then {
    $0.text = "하하"
    $0.textColor = .systemBlue
  }
  let dateTimeLabel = UILabel().then {
    $0.text = "하하"
    $0.textColor = .systemBlue
  }
  lazy var stackView = UIStackView().then {
    $0.axis = .vertical
    $0.addArrangedSubview(self.displaySiteNameLabel)
    $0.addArrangedSubview(self.dateTimeLabel)
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
    self.addSubview(self.stackView)
    self.stackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(5)
      $0.centerX.equalToSuperview()
    }
  }
}
