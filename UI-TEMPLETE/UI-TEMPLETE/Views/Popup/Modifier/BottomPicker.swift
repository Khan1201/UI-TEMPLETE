//
//  BottomPicker.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/30.
//

import SwiftUI
import PopupView

struct BottomPicker<T: View>: ViewModifier {
  @Binding var isPresented: Bool
  let view: T
  let dismissAction: (() -> Void)?
  
  func body(content: Content) -> some View {
    content
      .popup(isPresented: $isPresented) {
        view
      } customize: {
        $0
          .type(.toast)
          .position(.bottom)
          .animation(.default)
          .closeOnTap(false)
          .closeOnTapOutside(false)
          .dragToDismiss(false)
          .backgroundColor(.black.opacity(0.5))
          .dismissCallback {
            if let dismissAction {
              dismissAction()
            }
          }
      }
  }
}

extension View {
  func bottomPicker<T: View>(
    isPresented: Binding<Bool>,
    view: T,
    dismissAction: (() -> Void)? = nil
  ) -> some View {
    modifier(BottomPicker(
      isPresented: isPresented,
      view: view,
      dismissAction: dismissAction)
    )
  }
}
