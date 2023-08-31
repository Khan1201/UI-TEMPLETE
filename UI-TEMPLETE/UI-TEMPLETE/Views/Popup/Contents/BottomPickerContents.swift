//
//  BottomPickerContents.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/31.
//

import SwiftUI

struct BottomPickerContents<T: Selectable>: View {
  let title: String
  let items: [T]
  let onTapGesture: () -> Void
  
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
        }
        
        VStack(alignment: .leading, spacing: 0) {
          ForEach(items, id: \.value) { item in
            Text(item.value)
              .font(.system(size: 14, weight: .medium))
              .foregroundColor(Color.gray)
              .padding(.vertical, 13.5)
              .onTapGesture {
                onTapGesture()
              }
          }
        }
        .padding(.bottom, 45)
      }
      .padding(.leading, 24)
      .background(.blue)
      .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

struct BottomPickerContents_Previews: PreviewProvider {
    static var previews: some View {
      BottomPickerContents<ExampleItem>(title: "해당되는 일차를 선택해 주세요", items: [.test1, .test2, .test3]) {
        ()
      }
    }
}

enum ExampleItem: Selectable {
  case test1, test2, test3
  
  var title: String {
    switch self {
    case .test1:
      return "테스트1 입니다"
    case .test2:
      return "테스트2 입니다"
    case .test3:
      return "테스트3 입니다"
    }
  }
  
  var value: String {
    switch self {
    case .test1:
      return "test_1"
    case .test2:
      return "test_2"
    case .test3:
      return "test_3"
    }
  }
}
