//
//  ViewController.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import UIKit
import Toast_Swift
import RxSwift
import RxCocoa
import SnapKit

final class ImageListViewController: BaseViewController {
  
  // MARK: - Constants
  
  struct Metric {
    static let padding: CGFloat = 3
    static let cellWidth = UIScreen.main.bounds.width / 3 - 2
    static let CellHeight = UIScreen.main.bounds.width / 3 - 2
  }
  
  
  // MARK: - Properties
  
  var viewModel: ImageListViewModelType
  
  
  // MARK: - UI
  
  let loadingActivity = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
  }
  let searchController = UISearchController(searchResultsController: nil).then {
    $0.obscuresBackgroundDuringPresentation = false
    $0.hidesNavigationBarDuringPresentation = false
    $0.definesPresentationContext = true
  }
  let imageListView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout().then {
      $0.minimumLineSpacing = Metric.padding
      $0.minimumInteritemSpacing = Metric.padding
      $0.scrollDirection = .vertical
      $0.itemSize = CGSize(width: Metric.cellWidth, height: Metric.CellHeight)
    }
  ).then {
    $0.backgroundColor = .white
    $0.keyboardDismissMode = .interactive
    $0.register(ImageListCell.self, forCellWithReuseIdentifier: ImageListCell.CellID)
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
    self.navigationItem.largeTitleDisplayMode = .always
    self.navigationItem.title = "이미지 검색"
    self.navigationItem.hidesSearchBarWhenScrolling = false
    self.navigationItem.searchController = self.searchController
  }
  
  
  // MARK: - Bind
  
  override func bind() {
    
    // UI CONTROL
    self.imageListView.rx.didEndDragging
      .subscribe { [weak self] _ in
        guard let `self` = self else { return }
        self.searchController.searchBar.endEditing(true)
      }
      .disposed(by: self.disposeBag)
    
    // INPUT
    let searchBarOb = self.searchController.searchBar.rx.text
      .orEmpty
      .distinctUntilChanged()
      .share()
    
    searchBarOb
      .debounce(.seconds(1), scheduler: MainScheduler.instance)
      .bind(to: self.viewModel.searchImage)
      .disposed(by: self.disposeBag)
    
    searchBarOb
      .map { $0.isEmpty }
      .bind(to: self.viewModel.searchEmptyState)
      .disposed(by: self.disposeBag)
    
    self.imageListView.rx.needToFetchMoreData
      .filter { $0 }
      .map { _ in }
      .bind(to: viewModel.nextPageImage)
      .disposed(by: disposeBag)
    
    self.imageListView.rx.modelSelected(Image.self)
      .map(ImageListViewModel.createForImageDetail)
      .subscribe(onNext: { [weak self] vc in
        guard let `self` = self else { return }
        self.present(vc, animated: true, completion: nil)
      })
      .disposed(by: self.disposeBag)
    
    // OUTPUT
    self.viewModel.allImageList
      .bind(to: self.imageListView.rx.items(
        cellIdentifier: ImageListCell.CellID,
        cellType: ImageListCell.self
      )) {
        _, item, cell in
        cell.setData(image: item)
      }
      .disposed(by: self.disposeBag)
    
    self.viewModel.loadingState
      .subscribe(onNext: self.loadingStateHandle)
      .disposed(by: self.disposeBag)
    
    self.viewModel.cellBackgroundState
      .subscribe(onNext: { [weak self] state in
        guard let `self` = self else { return }
        self.imageListView.setDescriptView(type: state)
      })
      .disposed(by: self.disposeBag)
    
    self.viewModel.errorMessage
      .subscribe(onNext: { [weak self] str in
        guard let `self` = self else { return }
        self.view.makeToast(str, duration: 2.0, position: .center)
        self.searchController.searchBar.text = ""
        self.searchController.searchBar.endEditing(true)
      })
      .disposed(by: self.disposeBag)
  }
  
  
  // MARK: - SetupConstraints
  
  override func setupConstraints() {
    self.view.addSubview(self.imageListView)
    self.view.addSubview(self.loadingActivity)
    self.view.bringSubviewToFront(self.loadingActivity)
    
    self.imageListView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }
    
    self.loadingActivity.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}

extension ImageListViewController {
  private func loadingStateHandle(_ state: LoadingState) {
    switch state {
    case .loading:
      self.imageListView.alpha = 0
      self.loadingActivity.startAnimating()
    case .finish:
      self.imageListView.alpha = 1
      self.loadingActivity.stopAnimating()
    case .empty:
      self.imageListView.alpha = 1
      self.loadingActivity.stopAnimating()
    case .error:
      self.imageListView.alpha = 0
      self.loadingActivity.stopAnimating()
    }
  }
}
