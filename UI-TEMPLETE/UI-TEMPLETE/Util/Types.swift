//
//  Types.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/09/01.
//

import Foundation

enum ExampleItem: Selectable {
  case test1, test2, test3
  
  var title: String {
    switch self {
    case .test1:
      return "테스트1 입니다"
    case .test2:
      return "테스트2 입니다"
    case .test3:
      return "테스트3 입니다"
    }
  }
  
  var value: String {
    switch self {
    case .test1:
      return "test_1"
    case .test2:
      return "test_2"
    case .test3:
      return "test_3"
    }
  }
}
