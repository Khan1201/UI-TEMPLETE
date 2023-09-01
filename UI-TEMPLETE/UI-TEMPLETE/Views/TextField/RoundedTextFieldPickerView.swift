//
//  RoundedTextFieldPickerView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/01.
//

import SwiftUI

struct RoundedTextFieldPickerView<T: Selectable>: View {
  let title: String?
  @Binding var value: T
  let placeholder: String
  @Binding var showPicker: Bool

  @State private var isOnceSelected: Bool = false
  
  var titleFontColor: (Font, Color) = (.title3, Color.black)
  var valueFontColor: (Font, Color) = (.body, Color.black)
  var placeholderFontColor: (Font, Color) = (.body, Color.gray)
  
    var body: some View {
      
      VStack(alignment: .leading, spacing: 8) {
        if let title = title {
          Text(title)
            .font(titleFontColor.0)
            .foregroundColor(titleFontColor.1)
        }
        
        Text(isOnceSelected ? value.title : placeholder)
          .font(isOnceSelected ? valueFontColor.0 : placeholderFontColor.0)
          .foregroundColor(isOnceSelected ? valueFontColor.1 : placeholderFontColor.1)
          .padding(.vertical, 13.5)
          .padding(.leading, 16)
          .frame(maxWidth: .infinity, alignment: .leading)
          .overlay {
            RoundedRectangle(cornerRadius: 8)
              .strokeBorder(showPicker ? Color.black : Color.gray)
          }
          .onTapGesture {
            showPicker = true
          }
      }
      .onChange(of: value.value) { _ in
        isOnceSelected = true
      }
    }
}

struct RoundedTextFieldPickerView_Previews: PreviewProvider {
    static var previews: some View {
      RoundedTextFieldPickerView<ExampleItem>(title: "Title", value: .constant(.test1), placeholder: "Placeholder", showPicker: .constant(false))
    }
}
