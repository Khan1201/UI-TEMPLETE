//
//  Dummy.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/01.
//

import Foundation

final class Dummy {
  
  public static var scheduledChildBirthRange: ClosedRange<Date> = {
    
    let calendar = Calendar.current
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy"
    let currentYear = Int(dateFormatter.string(from: Date())) ?? 2023
    
    dateFormatter.dateFormat = "M"
    let currentMonth = Int(dateFormatter.string(from: Date())) ?? 1
    
    dateFormatter.dateFormat = "d"
    let currentDay = Int(dateFormatter.string(from: Date())) ?? 1
    
    let startComponents = DateComponents(year: currentYear, month: currentMonth, day: currentDay)
    let endComponents = DateComponents(year: currentYear + 1, month: currentMonth, day: currentDay)
    return calendar.date(from: startComponents)! ...
    calendar.date(from: endComponents)!
  }()
}
