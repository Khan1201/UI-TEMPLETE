//
//  ViewToImageVM.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/09.
//

import Foundation

final class ViewToImageVM: ObservableObject {
  
  @Published var showSaveAlert: Bool = false
  @Published var isSaveSucceess: Bool = false
}
