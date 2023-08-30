//
//  RoundedTextField.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/30.
//

import SwiftUI

struct RoundedTextField: View {
//  @State var value: String = "" // For test
  @Binding var value: String
  @Binding var showKeyboard: Bool
  let title: String
  let placeHolder: String
  let maxCount: Int
  var showCurrentMaxCount: Bool = false
  
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.system(size: 14))
          .foregroundColor(Color.black)
        
        TextField(placeHolder, text: $value)
          .font(.system(size: 14))
          .foregroundColor(showKeyboard ? Color.black : Color.gray)
          .textFieldStyle(
            RoundedTextFieldStyle(
              verticalPadding: 13.5,
              leadingPadding: 16,
              borderColor: showKeyboard ? Color.black : Color.gray,
              cornerRadius: 8
            )
          )
          .keyboardType(showCurrentMaxCount ? .default : .numberPad)
          .overlay(alignment: .trailing) {
            HStack(alignment: .center, spacing: 4) {
              Image("x.circle.gray.24x24")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                  value = ""
                }
              
              if showCurrentMaxCount {
                HStack(alignment: .center, spacing: 0) {
                  Text(value)
                    .foregroundColor(Color.red)
                  Text("/\(maxCount)")
                    .foregroundColor(Color.gray)
                }
                .font(.system(size: 12))
              }
            }
            .padding(.trailing, showCurrentMaxCount ? 12 : 16)
            .opacity(value.count > 0 ? 1 : 0)
          }
      }
      .onChange(of: value) { newValue in
        if newValue.count > maxCount {
          value.removeLast()
        }
      }
    }
}

struct RoundedTextField_Previews: PreviewProvider {
    static var previews: some View {
      RoundedTextField(value: .constant(""), showKeyboard: .constant(false), title: "Title", placeHolder: "PlaceHolder", maxCount: 4)
      
      // For test
//      RoundedTextField(showKeyboard: .constant(false), title: "Title", placeHolder: "PlaceHolder", maxCount: 4)
    }
}

struct RoundedTextFieldStyle: TextFieldStyle {
  let verticalPadding: CGFloat
  let leadingPadding: CGFloat
  let borderColor: Color
  let cornerRadius: CGFloat
  
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(.vertical, verticalPadding)
      .padding(.leading, leadingPadding)
      .overlay {
        RoundedRectangle(cornerRadius: cornerRadius)
          .strokeBorder(borderColor)
      }
  }
}
