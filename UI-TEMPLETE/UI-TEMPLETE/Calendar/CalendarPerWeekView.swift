//
//  CalendarPerWeekView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/10.
//

import SwiftUI

struct CalendarPerWeekView: View {
  
  @StateObject var viewModel: CalendarPerWeekVM = CalendarPerWeekVM()
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center, spacing: 10) {
        
        Image(systemName: "arrow.left")
          .resizable()
          .frame(width: 30, height: 30)
          .onTapGesture {
            viewModel.arrowOnTapGesture(isLeft: true)
          }
        
        HStack(alignment: .center, spacing: 10) {
          ForEach(viewModel.daysInCurrentWeek.indices, id: \.self) { i in
            
            VStack(alignment: .center, spacing: 10) {
              Text(viewModel.weekdaySymbols[i])
                .font(.system(size: 13, weight: .medium))
              
              Text("\(viewModel.daysInCurrentWeek[i] == 0 ? "" : "\(viewModel.daysInCurrentWeek[i])")")
                .font(.system(size: 13, weight: .medium))
            }
          }
        }
        
        
        Image(systemName: "arrow.right")
          .resizable()
          .frame(width: 30, height: 30)
          .onTapGesture {
            viewModel.arrowOnTapGesture(isLeft: false)
          }
      }
    }
    .task {
      viewModel.calendarPerWeekViewOnAppearAction()
    }
  }
}

struct CalendarPerWeekView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarPerWeekView()
  }
}
