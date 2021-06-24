//
//  ImageDetailViewController.swift
//  ImageSearch
//
//  Created by once on 2021/06/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

final class ImageDetailViewController: BaseViewController {
  
  // MARK: - Property
  
  var statusState: Bool = true
  
  
  // MARK: - UI
  
  let detailImageView = UIImageView()
  let scrollView = UIScrollView()
  let topStatusView = ImageDetailTopView()
  let bottomStatusView = ImageDetailBottomView()
  
  
  // MARK: - Status Bar handle variable
  
  override var prefersStatusBarHidden: Bool {
    return !self.statusState
  }
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .fade
  }
  
  
  // MARK: - ViewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.scrollView.do {
      $0.contentSize = self.detailImageView.bounds.size
    }
  }
  
  
  // MARK: - Bind
  
  override func bind() {
    self.view.rx.tapGesture()
      .when(.recognized)
      .map { _ in }
      .subscribe(onNext: self.statusBarHandle)
      .disposed(by: self.disposeBag)
  }
  
  
  // MARK: - SetupConstraints
  
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

extension ImageDetailViewController {
  private func statusBarHandle() {
    self.statusState.toggle()
    if self.statusState {
      UIView.animateFadeIn([self.topStatusView, self.bottomStatusView])
      UIView.animate(withDuration: 0.2, animations: {
        self.setNeedsStatusBarAppearanceUpdate()
      })
    } else {
      UIView.animateFadeOut([self.topStatusView, self.bottomStatusView])
      UIView.animate(withDuration: 0.2, animations: {
        self.setNeedsStatusBarAppearanceUpdate()
      })
    }
  }
}
