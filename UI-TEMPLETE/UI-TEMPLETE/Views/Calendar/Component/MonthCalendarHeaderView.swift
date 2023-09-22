//
//  MonthCalendarHeaderView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/22.
//

import SwiftUI

struct MonthCalendarHeaderView: View {
  @Binding var dateForMonth: Date
  let weekdaySymbols: [String]
  
  /// true -> left, false -> right
  let chevronOnTapGesture: (Bool) -> Void
  
  var body: some View {
    let weekdaySymbolWidth: CGFloat = (UIScreen.screenWidth - 47 - 48) / 7

    VStack(spacing: 0) {
      HStack(alignment: .center, spacing: 0) {
        
        Image(systemName: "chevron.left")
          .resizable()
          .frame(width: 8, height: 8)
          .padding(.leading, 36)
          .padding(.vertical, 12)
          .onTapGesture {
            chevronOnTapGesture(true)
          }
        
        Spacer()
        
        Text(dateForMonth.toString(format: "yyyy년 M월"))
          .font(.system(size: 14, weight: .medium))
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .resizable()
          .frame(width: 8, height: 8)
          .padding(.trailing, 36)
          .onTapGesture {
            chevronOnTapGesture(false)
          }
      }
      .frame(maxWidth: .infinity, alignment: .center)
      
      
      
      HStack(spacing: 8) {
        ForEach(weekdaySymbols, id: \.self) { symbol in
          Text(symbol)
            .font(.system(size: 12, weight: .medium))
            .frame(width: weekdaySymbolWidth)
            .padding(.vertical, 8)
          
        }
      }
      .frame(maxWidth: .infinity, alignment: .center)
    }
  }
}

struct MonthCalendarHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    MonthCalendarHeaderView(
      dateForMonth: .constant(Date()),
      weekdaySymbols: ["일", "월", "화", "수", "목", "금", "토"], chevronOnTapGesture: { _ in }
    )
  }
}
