//
//  BaseViewController.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import UIKit
import SnapKit
import RxSwift
import Then

class BaseViewController: UIViewController {
  
  // MARK: - Property
  
  var disposeBag = DisposeBag()
  let viewWidth = UIScreen.main.bounds.width
  let viewHeight = UIScreen.main.bounds.height
  
  // MARK: - Init
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.setupConstraints()
    self.bind()
  }
  
  // override point
  func setupConstraints() {
    
  }
  
  func bind() {
    
  }
}
