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
    $0.textAlignment = .right
    $0.textColor = .systemBlue
    $0.font = UIFont.systemFont(ofSize: 17)
  }
  let dateTimeLabel = UILabel().then {
    $0.textAlignment = .right
    $0.textColor = .systemBlue
    $0.font = UIFont.systemFont(ofSize: 12)
  }
  lazy var stackView = UIStackView().then {
    $0.axis = .vertical
    $0.addArrangedSubview(self.displaySiteNameLabel)
    $0.addArrangedSubview(self.dateTimeLabel)
  }
  
  
  // MARK: - Initialize
  
  init() {
    super.init(frame: CGRect.zero)
    self.backgroundColor = #colorLiteral(red: 0.8503718341, green: 0.8492820702, blue: 0.8683175312, alpha: 1)
    self.setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraints() {
    self.addSubview(self.stackView)
    self.stackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(5)
      $0.trailing.equalToSuperview().offset(-10)
    }
  }
}
