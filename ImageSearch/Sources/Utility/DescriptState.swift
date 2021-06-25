//
//  DescriptState.swift
//  ImageSearch
//
//  Created by once on 2021/06/24.
//

import UIKit

enum DescriptState {
  case empty
  case finish
  case loading
  case error
  
  var descriptView: UIView {
    let newView = DescriptView()
    switch self {
    case .empty:
      newView.descriptImageView.image
        = UIImage().setSFSymbols(systemName: "magnifyingglass", weight: .regular)
      newView.descriptLabel.text = "검색어 입력"
      return newView
    case .finish:
      newView.descriptImageView.image = nil
      newView.descriptLabel.text = ""
    case .loading:
      newView.descriptImageView.image = nil
      newView.descriptLabel.text = ""
    case .error:
      newView.descriptImageView.image
        = UIImage().setSFSymbols(systemName: "xmark.octagon", weight: .regular)
      newView.descriptLabel.text = "검색 결과가 없습니다."
    }
    
    return newView
  }
}
