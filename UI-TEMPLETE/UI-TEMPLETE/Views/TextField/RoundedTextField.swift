//
//  RoundedTextField.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/30.
//

import SwiftUI

struct RoundedTextField: View {
  let title: String?
  let placeholder: String
  @Binding var value: String
  @Binding var canDone: Bool
  let maxCount: Int
  var minCount: Int = 1
  var keyboardAppearAction: (() -> Void)?
  var keyboardHideAction: (() -> Void)?
  var showCurrentMaxCount: Bool = false
  
  @FocusState private var isFocused: Bool
  
  // Design
  var titleFontColor: (Font, Color) = (.title, Color.black)
  var valueFontColor: (Font, Color) = (.body, Color.black)
  var placeholderFontColor: (Font, Color) = (.body, Color.gray)
  var verticalPadding: CGFloat = 13.5
  var leadingPadding: CGFloat = 16
  var borderColorWhenKeyboardShow: Color = Color.black
  var borderColorWhenKeyboardHide: Color = Color.gray
  var cornerRadius: CGFloat = 8
    
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      if let title = title {
        Text(title)
          .font(titleFontColor.0)
          .foregroundColor(titleFontColor.1)
      }
      
      TextField("", text: $value)
        .font(valueFontColor.0)
        .foregroundColor(valueFontColor.1)
        .textFieldStyle(
          RoundedTextFieldStyle(
            verticalPadding: verticalPadding,
            leadingPadding: leadingPadding,
            borderColor: isFocused ? borderColorWhenKeyboardShow : borderColorWhenKeyboardHide,
            cornerRadius: cornerRadius
          )
        )
        .placeholder(when: value.count == 0) {
          Text(placeholder)
            .font(placeholderFontColor.0)
            .foregroundColor(placeholderFontColor.1)
            .padding(.leading, 16)
        }
        .focused($isFocused)
        .onTapGesture {
          isFocused = true
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
                Text("\(value.count)")
                  .foregroundColor(Color.red)
                Text("/\(maxCount)")
                  .foregroundColor(Color.black)
              }
              .font(.body)
            }
          }
          .padding(.trailing, showCurrentMaxCount ? 12 : 16)
          .opacity(value.count > 0 && isFocused ? 1 : 0)
        }
    }
    .onChange(of: value) { _ in
      if value.count > maxCount {
        value.removeLast()
      }
      
      if value.count >= minCount {
        canDone = true
      } else {
        canDone = false
      }
    }
    .onChange(of: isFocused) { newValue in
      if newValue {
        if value.count >= minCount {
          canDone = true
        }
      }
    }
    .receiveKeyboardState {
      (keyboardAppearAction ?? {})()
      
    } hideAction: {
      isFocused = false
      (keyboardHideAction ?? {})()
    }
  }
}

struct RoundedTextField_Previews: PreviewProvider {
  static var previews: some View {
    RoundedTextField(title: "Title", placeholder: "PlaceHolder", value: .constant(""), canDone: .constant(false),   maxCount: 4)
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
