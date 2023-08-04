//
//  SliderView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/04.
//

import SwiftUI

struct SliderView: View {
  @State private var speed: CGFloat = 1
  @State private var filledWidth: CGFloat = 0
  @State private var translationWidth: CGFloat = 0
  @State private var endedWidth: CGFloat = 0
  @State private var stepedWidth: CGFloat = 0
  @State private var stepedCount: CGFloat = 1
  
  @State private var onEnded: Bool = false
  
  var horizontalPadding: CGFloat = 48
  
  var body: some View {
    let stepWidth: CGFloat = (UIScreen.screenWidth - horizontalPadding) / 4
    
    VStack(alignment: .leading, spacing: 0) {
      Slider(
        value: $speed,
        in: 1...5,
        step: 1,
        onEditingChanged: { _ in }
      )
      Text("translationWidth: \(translationWidth)")
      Text("stepWidth: \(stepWidth)")
      Text("stepedWidth: \(stepedWidth)")
      Text("filledWidth: \(filledWidth)")
      Text("stepedCount: \(stepedCount)")

      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.gray)
          .frame(maxWidth: .infinity, maxHeight: 5)
        
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.blue)
          .frame(width: filledWidth, height: 5)
        
        Circle()
          .fill(Color.red)
          .frame(maxWidth: 15, maxHeight: 15)
          .padding(.leading, filledWidth == 0 ? filledWidth : filledWidth - 15)
          .gesture(
            DragGesture()
              .onChanged({ value in
                  translationWidth = value.translation.width

                  
                  // 오른쪽으로 쭉 이동
                  // 만약 한번 때고 다시 이동 시, endWidth 더함
                  if value.translation.width + (onEnded ? endedWidth : 0) >=
                      stepedWidth - (stepedCount * 20) {
                    
                    filledWidth += stepWidth
                    stepedWidth += stepWidth
                    stepedCount += 1
                    
                  // 왼쪽으로 쭉 이동
                  // 만약 한번 때고 다시 이동 시, endWidth 더함
                  } else if value.translation.width + (onEnded ? endedWidth : 0) <=
                              filledWidth - stepWidth + 15 {
                    filledWidth -= stepWidth
                    stepedWidth -= stepWidth
                    stepedCount -= 1
                  }
              })
              .onEnded({ value in
                endedWidth = filledWidth
                onEnded = true
              })
          )
        
        Text("Reset")
          .onTapGesture {
            filledWidth = 0
            translationWidth = 0
            stepedWidth = (UIScreen.screenWidth - horizontalPadding) / 4
            stepedCount = 1
            onEnded = false
          }
          .padding(.top, 50)
      }
    }
    .padding(.horizontal, 24)
    .task {
      stepedWidth = stepWidth
    }
  }
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
    SliderView()
  }
}
