//
//  ViewToImagePracticeVM.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/09.
//

import Foundation
import UIKit

final class ViewToImagePracticeVM: ObservableObject {
  @Published var shareImage: ShareImage?
  @Published private(set) var savedImage: UIImage?
  @Published var showSaveAlert: Bool = false
  @Published private(set) var isSaveSucceess: Bool = false
}

//MARK: - Gesture..

extension ViewToImagePracticeVM {
  func exportOnTapGesture(image: UIImage) {
    shareImage = ShareImage(image: image)
  }
  
  func saveOnTapGesture(image: UIImage) {
    savedImage = image
    UIImageWriteToSavedPhotosAlbum(savedImage ?? UIImage(), nil, nil, nil)
  }
}

//MARK: - Detect actions..

extension ViewToImagePracticeVM {
  func savedImageOnChangeAction() {
    showSaveAlert = true
    isSaveSucceess = true
  }
}
