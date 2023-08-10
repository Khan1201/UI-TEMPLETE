//
//  Extensions.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/03.
//

import Foundation
import SwiftUI

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

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension View {
  func snapShot() -> UIImage {
    let controller = UIHostingController(rootView: self)
    let view = controller.view
    
    let targetSize = controller.view.intrinsicContentSize
    view?.bounds = CGRect(origin: .zero, size: targetSize)
    view?.backgroundColor = .clear
    
    let renderer = UIGraphicsImageRenderer(size: targetSize)
    
    return renderer.image { rendererContext in
      view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
    }
  }
}
