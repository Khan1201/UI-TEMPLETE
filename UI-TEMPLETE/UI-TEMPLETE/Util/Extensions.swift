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
  static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> Color {
    return Color(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0))
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
