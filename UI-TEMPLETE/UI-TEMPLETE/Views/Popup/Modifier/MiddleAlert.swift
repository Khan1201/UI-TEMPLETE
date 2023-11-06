//
//  MiddleAlert.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 11/6/23.
//

import SwiftUI
import PopupView

struct MiddleAlert<T: View>: ViewModifier {
  @Binding var isPresented: Bool
  let view: T
  let horizontalPadding: CGFloat
  let dismissAction: (() -> Void)?
  
  @State private var viewSize: CGSize = CGSize()
  
  func body(content: Content) -> some View {
    let bottomPadding: CGFloat = (UIScreen.screenHeight - viewSize.height) / 2
  
    content
      .popup(isPresented: $isPresented, view: {
        view
          .getSize(size: $viewSize)
          .padding(.bottom, bottomPadding)
          .padding(.horizontal, horizontalPadding)
        
      }, customize: {
        $0
          .type(.floater(verticalPadding: 0, horizontalPadding: 0, useSafeAreaInset: false))
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
      )
  }
}

extension View {
  func middleAlert<T: View>(
    isPresented: Binding<Bool>,
    view: T,
    horizontalPadding: CGFloat = 24,
    dismissAction: (() -> Void)? = nil
  ) -> some View {
    modifier(MiddleAlert(
      isPresented: isPresented,
      view: view,
      horizontalPadding: horizontalPadding,
      dismissAction: dismissAction)
    )
  }
}

