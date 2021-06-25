//
//  Reactive+Ext.swift
//  ImageSearch
//
//  Created by once on 2021/06/24.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UICollectionView {
  var needToFetchMoreData: ControlEvent<Bool> {
    let selector = #selector(UICollectionViewDelegateFlowLayout.scrollViewDidEndDragging(_:willDecelerate:))
    let source = self.delegate.methodInvoked(selector)
      .map { arg -> Bool in
        let scrollView = try castOrThrow(UIScrollView.self, arg[0])
        let offsetY = scrollView.contentOffset.y
        let totalScrollViewContentHeight = scrollView.contentSize.height
        let deviceViewHeight = scrollView.frame.size.height
        return offsetY > totalScrollViewContentHeight - deviceViewHeight
      }
    return ControlEvent(events: source)
  }
}

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
  guard let returnValue = object as? T else {
    throw RxCocoaError.castingError(object: object, targetType: resultType)
  }
  return returnValue
}
