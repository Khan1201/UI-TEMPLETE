//
//  ReceiveKeyboardState.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/31.
//

import SwiftUI

struct ReceiveKeybaordState: ViewModifier {
  let appearAction: () -> Void
  let hideAction: () -> Void
  
  func body(content: Content) -> some View {
    content
      .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
        appearAction()
      }
      .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
        hideAction()
      }
  }
}

extension View {
  func receiveKeyboardState(appearAction: @escaping () -> Void, hideAction: @escaping () -> Void) -> some View {
    modifier(ReceiveKeybaordState(appearAction: appearAction, hideAction: hideAction))
  }
}
