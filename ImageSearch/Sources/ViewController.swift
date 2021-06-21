//
//  ViewController.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import UIKit

class ViewController: UIViewController {
  let searchController = UISearchController(searchResultsController: nil)

  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.searchController = searchController
    self.view.backgroundColor = .white
  }
  
  
}
