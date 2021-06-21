//
//  ViewController.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import UIKit

class ImageListViewController: BaseViewController {
  
  // MARK: - Constants
  
  struct Metric {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
  }
  
  
  // MARK: - UI
  
  let searchController = UISearchController(searchResultsController: nil)
  let imageListView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.minimumLineSpacing = 2
      $0.minimumInteritemSpacing = 2
      $0.scrollDirection = .horizontal
      $0.itemSize = CGSize(width: Metric.width / 3 - 8,
                           height: Metric.width / 3 - 8)
    }
  ).then {
    $0.backgroundColor = .blue
    $0.register(ImageListCell.self,
                forCellWithReuseIdentifier: ImageListCell.CellID)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.searchController = self.searchController
  }
  
  override func bind() {
    
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

