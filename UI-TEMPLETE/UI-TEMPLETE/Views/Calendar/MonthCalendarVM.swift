//
//  CalendarVM.swift
//  heymama2-ios-app
//
//  Created by 윤형석 on 2023/08/02.
//

import Foundation

final class MainCalendarVM: ObservableObject {
  @Published var selectedDate = Date()
  @Published var dateForMonth: Date = Date()
  @Published var maxDayInMonth: Int = 0
  @Published var firstWeekdayInMonth: Int = 0
  
  var pageData: [Int] {
    return Array(repeating: 0, count: 24)
  }
  
  var weekdaySymbols: [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko")
    return calendar.shortWeekdaySymbols
  }
  
  var dateForMonthToInt: Int {
    return dateForMonth.toString(format: "M").toInt
  }
}

// MARK: - Set actions..

extension MainCalendarVM {
  /// Set 'maxDays' (해당 월에 존재하는 일자 수)
  func setMaxDayInMonth() {
    maxDayInMonth = Calendar.current.range(of: .day, in: .month, for: dateForMonth)?.count ?? 0
  }
  
  /// Set 'firstWeekDay' (해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일)
  func setFirstWeekdayInMonth() {
    let components = Calendar.current.dateComponents([.year, .month], from: dateForMonth)
    let date = Calendar.current.date(from: components)!
    firstWeekdayInMonth = Calendar.current.component(.weekday, from: date) - 1
  }
  
  /// Set 'dateForMonth' ( 'firstWeekday', 'maxDays' 에 기준이 되는 월)
  func setDateForMonth(byAdding value: Int) {
    guard let newMonth = Calendar.current.date(
      byAdding: .month,
      value: value,
      to: dateForMonth
    ) else { return }
    
    dateForMonth = newMonth
  }
  
  func setSelectedDate(day: Int, month: Date) {
    let monthToInt: Int = month.toString(format: "MM").toInt
    let yearToInt: Int = month.toString(format: "yyyy").toInt
    
    var dateComponents = DateComponents()
    dateComponents.year = yearToInt
    dateComponents.month = monthToInt
    dateComponents.day = day
    
    let result = Calendar.current.date(from: dateComponents) ?? Date()
    
    selectedDate = result
  }
}

// MARK: - Gestures..

extension MainCalendarVM {
  func dayOnTapGesture(day: Int, month: Date) {
    setSelectedDate(day: day, month: month)
  }
  
  func monthOnTapGesture(isLeft: Bool) {
    setDateForMonth(byAdding: isLeft ? -1 : 1)
    setMaxDayInMonth()
    setFirstWeekdayInMonth()
  }
  
  func pageDragGesture(currentIndex: Int, nextIndex: Int) {
    let isLeft = currentIndex - 1 == nextIndex
    monthOnTapGesture(isLeft: isLeft ? true : false)
  }
}

// MARK: - Appear(onApeear, task) action..

extension MainCalendarVM {
  func calendarViewOnAppearAction() {
    setMaxDayInMonth()
    setFirstWeekdayInMonth()
  }
}
