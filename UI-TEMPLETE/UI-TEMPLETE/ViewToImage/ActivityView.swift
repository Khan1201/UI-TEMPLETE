//
//  ActivityView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/09.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
  let image: UIImage
    
  func makeUIViewController(context: Context) -> some UIViewController {
    return UIActivityViewController(activityItems: [image], applicationActivities: nil)
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}
