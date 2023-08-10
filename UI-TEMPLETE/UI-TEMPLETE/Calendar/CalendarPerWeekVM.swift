//
//  CalendarPerWeekVM.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/10.
//

import Foundation

final class CalendarPerWeekVM: ObservableObject {
  @Published private(set) var currentMonth: Date = Date()
  @Published private(set) var maxDayInMonth: Int = 0
  @Published private(set) var firstWeekdayInMonth: Int = 0
  
  @Published private(set) var currentWeekInMonth: Int = 0
  @Published private(set) var numOfDaysPerWeekInMonth: [[Int]] = []
  @Published private(set) var daysInCurrentWeek: [Int] = []
  
  @Published private(set) var isSetDaysInCurrentWeek: Bool = false
  
  var weekdaySymbols: [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko")
    return calendar.shortWeekdaySymbols
  }
  
  func setMaxDayInMonth(month: Date) {
    maxDayInMonth = Calendar.current.range(of: .day, in: .month, for: month)?.count ?? 0
  }
  
  func setCurrentMonth(byAdding value: Int) {
    guard let newMonth = Calendar.current.date(
      byAdding: .month,
      value: value,
      to: currentMonth
    ) else { return }
    
    currentMonth = newMonth
  }
  
  func setFirstWeekdayInMonth(month: Date) {
    let components = Calendar.current.dateComponents([.year, .month], from: month)
    let date = Calendar.current.date(from: components)!
    firstWeekdayInMonth = Calendar.current.component(.weekday, from: date) - 1
  }
  
  func setNumOfDaysPerWeekInMonth(maxDay: Int, firstWeekday: Int) {
    var days: [Int] = []
    var endOfWeekIndex: Int = 6
    self.numOfDaysPerWeekInMonth = []
    
    for i in 0..<maxDay + firstWeekday {
      let day = i - firstWeekday + 1
      // 1 ~ maxDay 범위 내에 없을 시
      if i < firstWeekday || day > maxDay {
        days.append(0)
        
      } else {
        days.append(day) // 0 이 포함 됐으므로 -1
      }

      // 캘린더 기준 한 주의 끝(토요일)일 때
      if i == endOfWeekIndex || day == maxDay {
        
        // 마지막 주 array 7일 형태로 만들기
        if days.count < 7 {
          for _ in 0..<7 - days.count {
            days.append(0)
          }
        }
        
        self.numOfDaysPerWeekInMonth.append(days)
        days = []
        endOfWeekIndex += 7
      }
    }
  }
  
  /**
   Set `currentWeekInMonth`
   - parameter byAdding:더할 값
   byAdding == nil -> 첫 로드시 현재 일수에 맞는 week로 초기화
   byAdding != nil -> 현재 값 + value 값 (week change가 일어날 때)
   */
  func setCurrentWeekInMonth(byAdding value: Int? = nil, forceValue: Int? = nil) {
    
    if let value = value {
      currentWeekInMonth += value
      
    } else if let forceValue = forceValue {
      currentWeekInMonth = forceValue
      
    } else {
      for (index, numOfDays) in numOfDaysPerWeekInMonth.enumerated() {
        
        for day in numOfDays {
          if day == Date().toStringByFormat("d").toInt {
            self.currentWeekInMonth = index + 1
          }
        }
      }
    }
  }
  
  func setDaysInCurrentWeek(list: [[Int]], currentWeek: Int) {
    daysInCurrentWeek = list[currentWeek - 1]
    isSetDaysInCurrentWeek = true
  }
  
  func weekWillChangeAction(isLeft: Bool) {
    let maxWeekCountInMonth = self.numOfDaysPerWeekInMonth.count

    if isLeft {
      if self.currentWeekInMonth == 1 {
        
        // maxWeek으로 설정 필요, 현재 week가 1이므로 -1 후 +maxWeekCountInMonth
        monthChangeAction(
          byAddingMonth: -1
        )
        
      } else {
        weekChangeAction(byAdding: -1)
      }
      
    } else {
      if self.currentWeekInMonth == maxWeekCountInMonth {
        
        // 1로 설정 필요, 현재 week가 maxWeek이므로 -maxWeekCountInMonth 후 +1
        monthChangeAction(
          byAddingMonth: 1
        )
        
      } else {
        weekChangeAction(byAdding: 1)
      }
    }
    
    func monthChangeAction(byAddingMonth month: Int) {
      setCurrentMonth(byAdding: month)
      setMaxDayInMonth(month: self.currentMonth)
      setFirstWeekdayInMonth(month: self.currentMonth)
      setNumOfDaysPerWeekInMonth(
        maxDay: self.maxDayInMonth,
        firstWeekday: self.firstWeekdayInMonth
      )
      
      let isMinus: Bool = month < 0
      let maxWeekCountInMonth: Int = numOfDaysPerWeekInMonth.count
      setCurrentWeekInMonth(
        forceValue: isMinus ? maxWeekCountInMonth : 1
      )
      setDaysInCurrentWeek(
        list: self.numOfDaysPerWeekInMonth,
        currentWeek: self.currentWeekInMonth
      )
    }
    
    func weekChangeAction(byAdding week: Int) {
      setCurrentWeekInMonth(byAdding: week)
      setDaysInCurrentWeek(
        list: self.numOfDaysPerWeekInMonth,
        currentWeek: self.currentWeekInMonth
      )
    }
  }
  
  func calendarPerWeekViewOnAppearAction() {
    setMaxDayInMonth(month: self.currentMonth)
    setFirstWeekdayInMonth(month: self.currentMonth)
    setNumOfDaysPerWeekInMonth(
      maxDay: self.maxDayInMonth,
      firstWeekday: self.firstWeekdayInMonth
    )
    setCurrentWeekInMonth()
    setDaysInCurrentWeek(
      list: self.numOfDaysPerWeekInMonth,
      currentWeek: self.currentWeekInMonth
    )
  }
}
