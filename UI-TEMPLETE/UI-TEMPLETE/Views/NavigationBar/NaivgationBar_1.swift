//
//  NaivgationBar_1.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/31.
//

import SwiftUI

struct NaivgationBar_1: View {
  @Binding var isPresented: Bool
  let atNavigationView: Bool // true -> 네비게이션 뷰 dismiss, false -> isPresented = false
  @Environment(\.dismiss) private var dismiss
  
    var body: some View {
      HStack(alignment: .center, spacing: 0) {
        Image("arrow.left.black.24x24")
        .resizable()
        .frame(width: 24, height: 24)
        .padding(.vertical, 12)
        .padding(.leading, 20)
        .onTapGesture {
          if atNavigationView {
            dismiss()
          } else {
            isPresented = false
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct NaivgationBar_1_Previews: PreviewProvider {
    static var previews: some View {
      NaivgationBar_1(isPresented: .constant(true), atNavigationView: false)
    }
}
