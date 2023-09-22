//
//  MonthCalendarDaysView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/22.
//

import SwiftUI

struct MonthCalendarDaysView: View {
  @Binding var maxDay: Int
  @Binding var firstWeekday: Int
  @Binding var month: Date
  @Binding var selectedDate: Date
  let dayOnTapGesture: (Int, Date) -> Void
  
  var body: some View {
    let monthToInt: Int = month.toString(format: "M").toInt
    
    VStack(alignment: .center, spacing: 0) {
      
      HStack(alignment: .center, spacing: 8) {
        ForEach(0 ..< maxDay + firstWeekday, id: \.self) { index in
          
          if (index >= 0 && index <= 6) {
            MonthCalendarCellView(
              day: index - firstWeekday + 1,
              month: monthToInt,
              selectedDate: $selectedDate
            )
            .onTapGesture {
              dayOnTapGesture((index - firstWeekday + 1), month)
            }
            .opacity(index < firstWeekday ? 0 : 1)
            .padding(.vertical, 12)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 24)
      .background(Color.blue.opacity(0.3))
      
      HStack(alignment: .center, spacing: 8) {
        ForEach(0 ..< maxDay + firstWeekday, id: \.self) { index in
          
          if (index >= 7 && index <= 13) {
            MonthCalendarCellView(
              day: index - firstWeekday + 1,
              month: monthToInt,
              selectedDate: $selectedDate
            )
            .onTapGesture {
              dayOnTapGesture((index - firstWeekday + 1), month)
            }
            .opacity(index < firstWeekday ? 0 : 1)
            .padding(.vertical, 12)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 24)
      .background(Color.white)
      
      HStack(alignment: .center, spacing: 8) {
        ForEach(0 ..< maxDay + firstWeekday, id: \.self) { index in
          
          if (index >= 14 && index <= 20) {
            MonthCalendarCellView(
              day: index - firstWeekday + 1,
              month: monthToInt,
              selectedDate: $selectedDate
            )
            .onTapGesture {
              dayOnTapGesture((index - firstWeekday + 1), month)
            }
            .padding(.vertical, 12)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 24)
      .background(Color.blue.opacity(0.3))

      
      HStack(alignment: .center, spacing: 8) {
        ForEach(0 ..< maxDay + firstWeekday, id: \.self) { index in
          
          if (index >= 21 && index <= 27) {
            MonthCalendarCellView(
              day: index - firstWeekday + 1,
              month: monthToInt,
              selectedDate: $selectedDate
            )
            .onTapGesture {
              dayOnTapGesture((index - firstWeekday + 1), month)
            }
            .padding(.vertical, 12)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 24)
      .background(Color.white)
      
      HStack(alignment: .center, spacing: 8) {
        ForEach(0 ..< maxDay + firstWeekday, id: \.self) { index in
          
          if (index >= 28 && index <= 34) {
            MonthCalendarCellView(
              day: index - firstWeekday + 1,
              month: monthToInt,
              selectedDate: $selectedDate
            )
            .onTapGesture {
              dayOnTapGesture((index - firstWeekday + 1), month)
            }
            .padding(.vertical, 12)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 24)
      .background(Color.blue.opacity(0.3))

      
      HStack(alignment: .center, spacing: 8) {
        ForEach(0 ..< maxDay + firstWeekday, id: \.self) { index in
          
          if (index >= 35 && index <= 41) {
            MonthCalendarCellView(
              day: index - firstWeekday + 1,
              month: monthToInt,
              selectedDate: $selectedDate
            )
            .onTapGesture {
              dayOnTapGesture((index - firstWeekday + 1), month)
            }
            .padding(.vertical, 12)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal, 24)
      .background(Color.white)
    }
  }
}

struct MonthCalendarDaysView_Previews: PreviewProvider {
  static var previews: some View {
    MonthCalendarDaysView(
      maxDay: .constant(29),
      firstWeekday: .constant(5),
      month: .constant(Date()),
      selectedDate: .constant(Date()),
      dayOnTapGesture: { _,_ in }
    )
  }
}

