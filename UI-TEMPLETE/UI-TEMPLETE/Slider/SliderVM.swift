//
//  SliderVM.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/07.
//

import Foundation

final class SliderVM: ObservableObject {
  @Published var filledWidth: CGFloat = 0
  @Published var nextStepWidth: CGFloat = 0
  @Published var endedWidth: CGFloat = 0
  @Published var stepedCount: CGFloat = 0
  @Published var touchEnded: Bool = false
  
  let minMaxCount: (CGFloat, CGFloat) = (1, 5)
}

// MARK: - Gestures..

extension SliderVM {
  func resetButtonOnTapGesture(stepWidth: CGFloat) {
    filledWidth = 0
    nextStepWidth = stepWidth
    stepedCount = 1
    touchEnded = false
  }
}

// MARK: - Detect actions..

extension SliderVM {
  func dragGestureOnChangedAction(transWidth: CGFloat, stepWidth: CGFloat) {
    
    // 오른쪽으로 쭉 이동
    // 만약 한번 때고 다시 이동 시, endWidth 더함
    if transWidth + (touchEnded ? endedWidth : 0) >=
        nextStepWidth - (stepedCount * 15) && stepedCount < minMaxCount.1 {
      
      filledWidth += stepWidth
      nextStepWidth += stepWidth
      stepedCount += 1
      
    // 왼쪽으로 쭉 이동
    // 만약 한번 때고 다시 이동 시, endWidth 더함
    } else if transWidth + (touchEnded ? endedWidth : 0) <=
                filledWidth - stepWidth + 15 && stepedCount >= minMaxCount.0 {
      filledWidth -= stepWidth
      nextStepWidth -= stepWidth
      stepedCount -= 1
    }
  }
  
  func dragGestureOnEndedAction() {
    endedWidth = filledWidth
    touchEnded = true
  }
}

// MARK: - Appear(onAppear, task)

extension SliderVM {
  func viewWillAppearAction(stepWidth: CGFloat) {
    nextStepWidth = stepWidth
  }
}
