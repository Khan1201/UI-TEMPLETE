//
//  CameraPickerView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 11/6/23.
//

import SwiftUI

struct CameraPickerView: UIViewControllerRepresentable {
  private var sourceType: UIImagePickerController.SourceType = .camera
  private var onImagePicked: (UIImage) -> Void
  
  @Environment(\.dismiss) private var dismiss
  
  public init(onImagePicked: @escaping (UIImage) -> Void) {
    self.onImagePicked = onImagePicked
  }
  
  public func makeUIViewController(context: Context) -> some UIViewController {
    let picker = UIImagePickerController()
    picker.sourceType = sourceType
    picker.delegate = context.coordinator
    return picker
  }
  
  public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(
      onDismiss: { self.dismiss() },
      onImagePicked: self.onImagePicked
    )
  }
  
  final public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private let onDismiss: () -> Void
    private let onImagePicked: (UIImage) -> Void
    
    init(onDismiss: @escaping () -> Void, onImagePicked: @escaping (UIImage) -> Void) {
      self.onDismiss = onDismiss
      self.onImagePicked = onImagePicked
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[.originalImage] as? UIImage {
        self.onImagePicked(image)
      }
      self.onDismiss()
    }
  }
}
