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
  let content: T
  
  func body(content: Content) -> some View {
    content
      .popup(isPresented: $isPresented) {
        content
      } customize: {
        $0
          .type(.toast)
          .position(.bottom)
          .animation(.default)
          .closeOnTapOutside(true)
          .backgroundColor(.black.opacity(0.5))
      }
  }
}
