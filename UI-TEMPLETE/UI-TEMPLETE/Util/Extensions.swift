//
//  Extensions.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/03.
//

import Foundation
import SwiftUI

// MARK: - String

extension String {
  
  var toInt: Int {
    return Int(self) ?? 0
  }
}
// MARK: - Int

extension Int {
  
  func toTwoDigitIfOneDigit() -> Int {
    var toString = String(self)
    guard toString.count == 1 else { return self}
    toString.insert("0", at: toString.startIndex)
    
    return Int(toString) ?? self
  }
}

// MARK: - Date

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

// MARK: - UIScreen

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

// MARK: - View

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

// MARK: - Color

extension Color {
  init(hexCode: String, alpha: CGFloat = 1.0) {
      self.init(uiColor: UIColor(hexCode: hexCode, alpha: alpha))
  }
  
  static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> Color {
    return Color(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0))
  }
}

extension UIColor {
  convenience init(hexCode: String, alpha: CGFloat = 1.0) {
          var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
          
          if hexFormatted.hasPrefix("#") {
              hexFormatted = String(hexFormatted.dropFirst())
          }
          
          assert(hexFormatted.count == 6, "Invalid hex code used.")
          
          var rgbValue: UInt64 = 0
          Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
          
          self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                    alpha: alpha)
      }
}

// MARK: - UIApplication

extension UIApplication {
  
  func enableHidingKeyboardOnTapOutside() {
    
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    
    guard let window = windowScene?.windows.first else { return }
    
    let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
    tapRecognizer.cancelsTouchesInView = false
    tapRecognizer.delegate = self
    window.addGestureRecognizer(tapRecognizer)
  }
  
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

extension UIApplication: UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
  -> Bool {
      return false
    }
}

// MARK - Date

extension Date {
  func toString(format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.locale = Locale(identifier: "ko")
    
    return formatter.string(from: self)
  }
}

extension Date: Selectable {
  var title: String {
    return self.toString(format: "yyyy년 M월 dd일")
  }
  
  var value: String {
    return self.toString(format: "yyyy-M-d")
  }
}
