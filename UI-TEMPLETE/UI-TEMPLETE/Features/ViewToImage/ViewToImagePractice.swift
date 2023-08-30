//
//  ViewToImagePractice.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/08.
//

import SwiftUI

struct ViewToImagePractice: View {
  @StateObject var viewModel: ViewToImageVM = ViewToImageVM()

  var body: some View {
    VStack {
      textView
      textView
      textView

      Rectangle()
        .frame(width: 100, height: 100, alignment: .center)
      
      Text("Export")
        .font(.system(size: 14, weight: .bold))
        .padding(10)
        .overlay {
          RoundedRectangle(cornerRadius: 14)
            .strokeBorder(Color.red)
        }
        .onTapGesture {
          viewModel.exportOnTapGesture(image: self.snapShot())
        }
      
      Text("Save to Image")
        .font(.system(size: 14, weight: .bold))
        .padding(10)
        .overlay {
          RoundedRectangle(cornerRadius: 14)
            .strokeBorder(Color.red)
        }
        .onTapGesture {
          viewModel.exportOnTapGesture(image: self.snapShot())
        }
    }
    .padding(.bottom, 100)
    .sheet(item: $viewModel.shareImage) { shareImage in
      ActivityView(image: shareImage.image)
    }
    .onChange(of: viewModel.savedImage, perform: { _ in
      viewModel.savedImageOnChangeAction()
    })
    .alert("저장 \(viewModel.isSaveSucceess ? "성공" : "실패")",
           isPresented: $viewModel.showSaveAlert) {
      Button("확인", role: .cancel, action: {})
    }
  }
}

struct ViewToImagePractice_Previews: PreviewProvider {
  static var previews: some View {
    ViewToImagePractice()
  }
}

extension ViewToImagePractice {
  var textView: some View {
    
    Text("Hello, SwiftUI")
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(Capsule())
  }
}

struct ShareImage: Identifiable {
    let id = UUID()
    let image: UIImage
}
