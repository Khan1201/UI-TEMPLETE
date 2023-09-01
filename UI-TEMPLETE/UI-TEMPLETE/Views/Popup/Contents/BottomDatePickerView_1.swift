//
//  BottomDatePickerView_1.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/01.
//

import SwiftUI

struct BottomDatePickerView_1: View {
  let title: String
  @Binding var isPresented: Bool
  @Binding var date: Date
  let dateRange: ClosedRange<Date>
  let onTapGesture: () -> Void

  var titleFontColor: (Font, Color) = (.title3, Color.black)

    var body: some View {
      VStack(alignment: .leading, spacing: 0) {
        
        HStack(alignment: .center, spacing: 0) {
          Text(title)
            .font(titleFontColor.0)
            .foregroundColor(titleFontColor.1)
          
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
          DatePicker("",
                     selection: $date,
                     in: dateRange,
                     displayedComponents: .date)
          .labelsHidden()
          .environment(\.locale, Locale.init(identifier: "ko-KR"))
          .datePickerStyle(WheelDatePickerStyle())
          .onTapGesture {
            onTapGesture()
          }
        }
        .padding(.bottom, 50)
      }
      .padding(.leading, 24)
      .background(.white)
      .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

struct BottomDatePickerView_1_Previews: PreviewProvider {
    static var previews: some View {
      BottomDatePickerView_1(title: "출산 예정일을 선택해 주세요", isPresented: .constant(true), date: .constant(Date()), dateRange: Dummy.scheduledChildBirthRange, onTapGesture: {})
    }
}
