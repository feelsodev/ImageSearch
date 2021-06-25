//
//  NetworkManager.swift
//  ImageSearch
//
//  Created by once on 2021/06/21.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()

    /// 세션 설정
    var session: Session
    
    /// SessionTaskError 메세지
    var sessionTaskErrorMessage = "서버와의 연결이 불안정합니다."
    
    private init() {
      self.session = Session()
    }
}
