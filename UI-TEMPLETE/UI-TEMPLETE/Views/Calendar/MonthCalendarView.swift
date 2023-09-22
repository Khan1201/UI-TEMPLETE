//
//  MonthCalendarView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/22.
//

import SwiftUI
import SwiftUIPager

struct MonthCalendarView: View {
  @StateObject var viewModel: MainCalendarVM = MainCalendarVM()
  
  @State private var page: Page = .withIndex(0)
  @State private var size: CGSize = CGSize()
    
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Pager(page: page, data: viewModel.pageData, id: \.self) { _ in
        VStack {
          MonthCalendarHeaderView(
            dateForMonth: $viewModel.dateForMonth,
            weekdaySymbols: viewModel.weekdaySymbols,
            chevronOnTapGesture: viewModel.monthOnTapGesture(isLeft:)
          )
          MonthCalendarDaysView(
            maxDay: $viewModel.maxDayInMonth,
            firstWeekday: $viewModel.firstWeekdayInMonth,
            month: $viewModel.dateForMonth,
            selectedDate: $viewModel.selectedDate,
            dayOnTapGesture: viewModel.dayOnTapGesture(day:month:)
          )
          
          Spacer()

        }
        .getSize(size: $size)
        
      }
      .allowsDragging(false)
      .onPageWillTransition { result in
        switch result {
        case .success(let res):
          viewModel.pageDragGesture(
            currentIndex: res.currentPage,
            nextIndex: res.nextPage
          )
        case .failure:
          ()
        }
      }
      .background {
        Color.white
      }
      .frame(maxWidth: .infinity, maxHeight: size.height + 100)
      
    }
    .task {
      page = .withIndex(viewModel.dateForMonthToInt - 1)
      viewModel.calendarViewOnAppearAction()
    }
  }
}

struct MonthCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        MonthCalendarView()
    }
}
