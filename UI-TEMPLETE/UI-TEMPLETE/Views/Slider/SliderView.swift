//
//  SliderView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/04.
//

import SwiftUI

struct SliderView: View {
  var horizontalPadding: CGFloat = 48
  @StateObject var viewModel: SliderVM = SliderVM()
  
  var body: some View {
    let stepWidth: CGFloat = (UIScreen.screenWidth - horizontalPadding) / 4
    
    VStack(alignment: .leading, spacing: 0) {

      Text("stepWidth: \(stepWidth)")
      Text("nextStepWidth: \(viewModel.nextStepWidth)")
      Text("filledWidth: \(viewModel.filledWidth)")
      Text("stepedCount: \(viewModel.stepedCount)")

      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.gray)
          .frame(maxWidth: .infinity, maxHeight: 5)
        
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.blue)
          .frame(width: viewModel.filledWidth, height: 5)
        
        Circle()
          .fill(Color.red)
          .frame(maxWidth: 15, maxHeight: 15)
          .padding(.leading, viewModel.filledWidth == 0 ?
                   viewModel.filledWidth : viewModel.filledWidth - 15)
          .gesture(
            DragGesture()
              .onChanged { value in
                viewModel.dragGestureOnChangedAction(
                  transWidth: value.translation.width,
                  stepWidth: stepWidth
                )
              }
              .onEnded { value in
                viewModel.dragGestureOnEndedAction()
              }
          )
      }
      .padding(.top, 20)
      
      Text("Reset")
        .padding()
        .overlay(content: {
          RoundedRectangle(cornerRadius: 12)
            .strokeBorder(Color.gray)
        })
        .onTapGesture {
          viewModel.resetButtonOnTapGesture(stepWidth: stepWidth)
        }
        .padding(.top, 20)
    }
    .padding(.horizontal, 24)
    .task {
      viewModel.viewWillAppearAction(stepWidth: stepWidth)
    }
  }
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
    SliderView()
  }
}
