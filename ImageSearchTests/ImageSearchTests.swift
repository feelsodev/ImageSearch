//
//  ImageSearchTests.swift
//  ImageSearchTests
//
//  Created by once on 2021/06/21.
//

import RxSwift
import RxBlocking
import XCTest

@testable import ImageSearch

class ImageSearchTests: XCTestCase {
  let networkStub = NetworkServiceStub()
  var model: ImageListModel!
  var viewModel: ImageListViewModel!
  
  override func setUp() {
    self.model = ImageListModel(repository: self.networkStub)
    self.viewModel = ImageListViewModel(model: self.model)
  }
  
  func testSearch() {
    /// 테스트를 위한 임시 검색어 데이터 onNext
    self.viewModel.searchImage.onNext("Test data input")
    
    let testArray: [Image] = ImageDummyData.imageArry
    let images = try! self.viewModel.allImageList.toBlocking(timeout: 201).first()!
    
    XCTAssertEqual(images, testArray)
  }
  
  
  func testSearchEmpty() {
    /// 검색어가 비어있을 시에 모든 Image 데이터 remove
    self.viewModel.searchImage.onNext("")
    
    let testArray: [Image] = []
    let images = try! self.viewModel.allImageList.toBlocking().first()!

    XCTAssertEqual(images, testArray)
  }
}
