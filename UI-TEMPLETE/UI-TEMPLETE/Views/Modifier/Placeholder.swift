//
//  Placeholder.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/01.
//

import SwiftUI

extension View {
  func placeholder<Content: View>(
    when shouldShow: Bool,
    alignment: Alignment = .leading,
    @ViewBuilder placeholder: () -> Content) -> some View {
      
      ZStack(alignment: alignment) {
        placeholder().opacity(shouldShow ? 1 : 0)
        self
      }
    }
}
