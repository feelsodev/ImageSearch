//
//  ViewController.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ImageListViewController: BaseViewController {
  
  
  
  // MARK: - Constants
  
  struct Metric {
    static let cellWidth = UIScreen.main.bounds.width / 3
    static let CellHeight = UIScreen.main.bounds.height / 3
  }
  
  
  // MARK: - Properties
  
  var viewModel: ImageListViewModelType
  
  
  // MARK: - UI
  
  let searchController = UISearchController(searchResultsController: nil)
  let imageListView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.minimumLineSpacing = .zero
      $0.minimumInteritemSpacing = .zero
      $0.scrollDirection = .vertical
      $0.itemSize = CGSize(width: Metric.cellWidth,
                           height: Metric.CellHeight)
    }
  ).then {
    $0.backgroundColor = .blue
    $0.register(
      ImageListCell.self,
      forCellWithReuseIdentifier: ImageListCell.CellID
    )
  }
  
  
  // MARK: - Initialize
  
  init(viewModel: ImageListViewModelType = ImageListViewModel()) {
    self.viewModel = viewModel
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - ViewDidLoad
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.searchController = self.searchController
  }
  
  
  // MARK: - Bind
  
  override func bind() {
    
    // INPUT
    self.searchController.searchBar.rx.text
      .orEmpty
      .skip(1)
      .debounce(.seconds(1), scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .bind(to: self.viewModel.searchImage)
      .disposed(by: self.disposeBag)
    
    // OUTPUT
    self.viewModel.allImageList
      .subscribe { imageList in
        print(imageList)
      }
      .disposed(by: self.disposeBag)
  }
  
  override func setupConstraints() {
    self.view.addSubview(self.imageListView)
    
    self.imageListView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}
