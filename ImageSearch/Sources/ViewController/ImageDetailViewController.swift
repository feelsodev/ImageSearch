//
//  ImageDetailViewController.swift
//  ImageSearch
//
//  Created by once on 2021/06/25.
//

import UIKit

final class ImageDetailViewController: BaseViewController {
  let detailImageView = UIImageView()
  let scrollView = UIScrollView()
  let topStatusView = ImageDetailTopView()
  let bottomStatusView = ImageDetailBottomView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .black
    self.scrollView.do {
      $0.contentSize = self.detailImageView.bounds.size
    }
  }
  
  override func setupConstraints() {
    [self.topStatusView, self.bottomStatusView, self.scrollView]
      .forEach { self.view.addSubview($0) }
    self.scrollView.addSubview(self.detailImageView)
    
    self.scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    self.topStatusView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalToSuperview()
      $0.height.equalTo(70)
    }
    self.bottomStatusView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(70)
    }
    self.detailImageView.snp.makeConstraints {
      $0.leading.trailing.equalTo(self.scrollView.frameLayoutGuide)
      $0.centerY.equalTo(self.scrollView)
    }
  }
}
