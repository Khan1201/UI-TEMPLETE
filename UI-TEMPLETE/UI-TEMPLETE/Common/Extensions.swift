//
//  Extensions.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/03.
//

import Foundation

extension Date {
  
  func toStringByFormat(_ format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: self)
  }
  
  static func currentDateToStringByFormat(_ format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: Date())
  }
}

extension String {
  
  var toInt: Int {
    return Int(self) ?? 0
  }
}

extension Int {
  
  func toTwoDigitIfOneDigit() -> Int {
    var toString = String(self)
    guard toString.count == 1 else { return self}
    toString.insert("0", at: toString.startIndex)
    
    return Int(toString) ?? self
  }
}
