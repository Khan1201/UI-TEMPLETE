//
//  PickerExampleView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/01.
//

import SwiftUI

struct PickerExampleView: View {
  @State private var showPicker: Bool = false
  @State private var showDatePicker: Bool = false
  
  @State private var selectedPickerItem: ExampleItem = .test1
  @State private var selectedDate: Date = Date(timeIntervalSince1970: 0)
  
  @State private var isPickerOnceSelected: Bool = false
  @State private var isDatePickerOnceSelected: Bool = false

  let pickerItems: [ExampleItem] = [.test1, .test2, .test3]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 50) {
      VStack(alignment: .leading, spacing: 4) {
        Text("일반 피커 띄우기")
          .font(.title2)
          .padding()
          .overlay {
            RoundedRectangle(cornerRadius: 12)
              .strokeBorder(Color.red)
          }
          .onTapGesture {
            showPicker = true
          }
        
        if isPickerOnceSelected {
          Text("선택된 아이템: \(selectedPickerItem.title)")
            .font(.body)
        }
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text("데이트 피커 띄우기")
          .font(.title2)
          .padding()
          .overlay {
            RoundedRectangle(cornerRadius: 12)
              .strokeBorder(Color.red)
          }
          .onTapGesture {
            showDatePicker = true
          }
        
        if isDatePickerOnceSelected {
          Text("선택된 아이템: \(selectedDate.title)")
            .font(.body)
        }
      }
    }
    .bottomPicker(
      isPresented: $showPicker,
      view: BottomPickerView_1(
        isPresented: $showPicker,
        title: "일반 Picker 예시입니다.",
        items: pickerItems,
        onTapGesture: { item in
          selectedPickerItem = item
          showPicker = false
          isPickerOnceSelected = true
        }
      )
    )
    .bottomPicker(
      isPresented: $showDatePicker,
      view: BottomDatePickerView_1(
        title: "Date Picker 예시입니다",
        isPresented: $showDatePicker,
        date: $selectedDate,
        dateRange: Dummy.scheduledChildBirthRange,
        onTapGesture: {
          showDatePicker = false
          isDatePickerOnceSelected = true
        }
      )
    )
  }
}

struct PickerExampleView_Previews: PreviewProvider {
  static var previews: some View {
    PickerExampleView()
  }
}
