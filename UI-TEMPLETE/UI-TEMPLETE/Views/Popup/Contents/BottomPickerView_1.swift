//
//  BottomPickerView_1.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/31.
//

import SwiftUI

struct BottomPickerView_1<T: Selectable>: View {
  @Binding var isPresented: Bool
  let title: String
  let items: [T]
  let onTapGesture: (T) -> Void
  
    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        
        HStack(alignment: .center, spacing: 0) {
          Text(title)
            .font(.system(size: 16, weight: .bold))
            .foregroundColor(Color.black)
          
          Spacer()
          
          Image("x.gray.24x24")
            .resizable()
            .frame(width: 24, height: 24)
            .padding(.trailing, 20)
            .padding(.vertical, 20)
            .onTapGesture {
              isPresented = false
            }
        }
        
        VStack(alignment: .leading, spacing: 0) {
          ForEach(items, id: \.value) { item in
            Text(item.value)
              .font(.system(size: 14, weight: .medium))
              .foregroundColor(Color.gray)
              .padding(.vertical, 13.5)
              .onTapGesture {
                onTapGesture(item)
              }
          }
        }
        .padding(.bottom, 50)
      }
      .padding(.leading, 24)
      .background(.blue.opacity(0.3))
      .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

struct BottomPickerView_1_Previews: PreviewProvider {
    static var previews: some View {
      BottomPickerView_1<ExampleItem>(isPresented: .constant(true), title: "해당되는 일차를 선택해 주세요", items: [.test1, .test2, .test3]) { _ in
        ()
      }
    }
}


