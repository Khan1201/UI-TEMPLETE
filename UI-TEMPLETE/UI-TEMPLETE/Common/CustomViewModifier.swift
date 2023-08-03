//
//  CustomViewModifier.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/03.
//

import SwiftUI


// MARK: - Get height

struct GetHeight: ViewModifier {
  @Binding var height: CGFloat
  
  func body(content: Content) -> some View {
    content
      .background {
        GeometryReader { proxy in
          Color.clear
            .onAppear {
              height = proxy.size.height
            }
        }
      }
  }
}

extension View {
  func getHeight(height: Binding<CGFloat>) -> some View {
    modifier(GetHeight(height: height))
  }
}

// MARK: -
