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
  
  let detailImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  lazy var scrollView = UIScrollView().then {
    $0.contentSize = CGSize(width: 475, height: 1500)
  }
  let topStatusView = ImageDetailTopView()
  let bottomStatusView = ImageDetailBottomView()
  
  
  // MARK: - System StatusBar handle variable
  
  override var prefersStatusBarHidden: Bool {
    return !self.statusState
  }
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .fade
  }
  
  
  // MARK: - Status value setting
  
  func setData(_ image: Image) {
    self.detailImageView.setImage(image.imageURL)
    self.bottomStatusView.do {
      $0.displaySiteNameLabel.text = image.displaySitename
      $0.dateTimeLabel.text = image.datetime.toDate
    }
    
    let widthRatio = self.viewWidth / CGFloat(image.width)
    let heightResult = CGFloat(image.height) * widthRatio
    self.scrollView.do {
      $0.contentSize = CGSize(width: self.viewWidth, height: heightResult)
    }
  }
  
  // MARK: - ViewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
  }
  
  
  // MARK: - Bind
  
  override func bind() {
    self.view.rx.tapGesture()
      .when(.recognized)
      .map { _ in }
      .subscribe(onNext: self.statusBarHandle)
      .disposed(by: self.disposeBag)
    
    self.topStatusView.backButton.rx.tap
      .subscribe(onNext: { [weak self] _ in
        guard let `self` = self else { return }
        self.dismiss(animated: true, completion: nil)
      })
      .disposed(by: self.disposeBag)
  }
  
  
  // MARK: - SetupConstraints
  
  override func setupConstraints() {
    [self.topStatusView, self.bottomStatusView, self.scrollView]
      .forEach { self.view.addSubview($0) }
    self.scrollView.addSubview(self.detailImageView)
    self.view.bringSubviewToFront(self.topStatusView)
    self.view.bringSubviewToFront(self.bottomStatusView)
    
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


// MARK: - StatusBar Handling

extension ImageDetailViewController {
  private func statusBarHandle() {
    self.statusState.toggle()
    if self.statusState {
      UIView.animateFadeIn([self.topStatusView, self.bottomStatusView])
      UIView.animate(withDuration: 0.2, animations: {
        self.setNeedsStatusBarAppearanceUpdate()
        self.view.backgroundColor = .white
      })
    } else {
      UIView.animateFadeOut([self.topStatusView, self.bottomStatusView])
      UIView.animate(withDuration: 0.2, animations: {
        self.setNeedsStatusBarAppearanceUpdate()
        self.view.backgroundColor = .black
      })
      
    }
  }
}
