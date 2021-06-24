//
//  String+Ext.swift
//  ImageSearch
//
//  Created by once on 2021/06/25.
//

import Foundation

extension String {
  var toDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = formatter.date(from: self) ?? Date()
    let result = "\(date)".split(separator: " ")
    return String(result[0] + " " + result[1])
  }
}
