//
//  CalendarVM.swift
//  heymama2-ios-app
//
//  Created by 윤형석 on 2023/08/02.
//

import Foundation

final class CalendarVM: ObservableObject {
  
  @Published private(set) var currentDate: Date = Date()
  @Published private(set) var dateForMonth: Date = Date()
  @Published private(set) var maxDays: Int = 0
  @Published private(set) var firstWeekday: Int = 0
  @Published private(set) var selectedDayAndMonth: (Int, Int) = (0, 0)
  
  var pageData: [Int] {
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  }
  
  var weekdaySymbols: [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko")
    return calendar.shortWeekdaySymbols
  }
  
  var dateForMonthToInt: Int {
    return dateForMonth.toStringByFormat("M").toInt
  }
  
//  private let util: ConstUtil = ConstUtil()
  
  init() {
    setMaxDays()
    setFirstWeekday()
        
    setSelectedDayAndMonth(
      dayAndMonth: (
        Date.currentDateToStringByFormat("d").toInt,
        Date.currentDateToStringByFormat("M").toInt
      )
    )
  }
  /// Set 'maxDays' (해당 월에 존재하는 일자 수)
  func setMaxDays() {
    maxDays = Calendar.current.range(of: .day, in: .month, for: dateForMonth)?.count ?? 0
  }
  
  /// Set 'firstWeekDay' (해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일)
  func setFirstWeekday() {
    let components = Calendar.current.dateComponents([.year, .month], from: dateForMonth)
    let date = Calendar.current.date(from: components)!
    firstWeekday = Calendar.current.component(.weekday, from: date) - 1
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
  
  /// Set 'currentDate' (선택된 날짜)
  func setCurrentDate(day: Int) {
    var twoDigitDay = day.toTwoDigitIfOneDigit()
    
    let month = Calendar.current.component(.month, from: dateForMonth)
    let year = Calendar.current.component(.year, from: dateForMonth)
    
    let dateFormatter = DateFormatter()
    currentDate = dateFormatter.date(from: "\(year)\(month)\(twoDigitDay)") ?? currentDate
  }
  
  func setSelectedDayAndMonth(dayAndMonth: (Int, Int)) {
    selectedDayAndMonth = dayAndMonth
  }
  
  func dayOnTapGesture(day: Int, month: Int) {
    setCurrentDate(day: day)
    setSelectedDayAndMonth(dayAndMonth: (day, month))
  }
  
  func monthOnTapGesture(isLeft: Bool) {
    setDateForMonth(byAdding: isLeft ? -1 : 1)
    setMaxDays()
    setFirstWeekday()
  }
  
  func pageDragGesture(currentIndex: Int, nextIndex: Int) {
    let isLeft = currentIndex - 1 == nextIndex
    monthOnTapGesture(isLeft: isLeft ? true : false)
  }
}
