//
//  MonthCalendarCellView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/22.
//

import SwiftUI

struct MonthCalendarCellView: View {
  let day: Int
  let month: Int
  @Binding var selectedDate: Date
  
  var body: some View {
    let width: CGFloat = (UIScreen.screenWidth - 48 - 48) / 7
    let isFocused: Bool = day == selectedDate.toString(format: "d").toInt &&
    month == selectedDate.toString(format: "MM").toInt
    let vSpacing: CGFloat = 16
    let verticalPadding: CGFloat = 8
    
    VStack(spacing: vSpacing) {
      Text("\(day)")
        .font(.system(size: 15, weight: .medium))
        .foregroundColor(Color.gray)
      
      Circle()
        .fill(Color.blue.opacity(0.6))
        .frame(width: 4, height: 4)
        .padding(8)
        .opacity(isFocused ? 1 : 0)

    }
    .frame(width: width)
    .padding(.vertical, verticalPadding)
    .background(isFocused ? Color.blue.opacity(0.8) : .clear)
    .cornerRadius(8)
  }
}

struct MonthCalendarCellView_Previews: PreviewProvider {
    static var previews: some View {
      MonthCalendarCellView(
        day: 2,
        month: 2,
        selectedDate: .constant(Date())
      )
    }
}
