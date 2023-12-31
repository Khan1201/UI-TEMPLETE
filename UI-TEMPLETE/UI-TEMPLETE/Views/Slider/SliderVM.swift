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
  
  let scoreTopPadding: CGFloat
  let horizontalPadding: CGFloat
  let maxCount: Int
  let lineHeight: CGFloat
  let circleWidthHeight: CGFloat
  
  let minCount: Int = 1
  var stepWidth: CGFloat = 0
  
  var isDragAvailable: Bool {
    return Int(stepedCount) < Int(maxCount) - 1
  }
  
  var fillCircleLeadingPadding: CGFloat {
    return filledWidth == 0 ? -(circleWidthHeight / 2) : filledWidth - circleWidthHeight
  }
  
  var scoreYOffset: CGFloat {
    return circleWidthHeight + scoreTopPadding
  }
  
  init(
    scoreTopPadding: CGFloat = 5,
    horizontalPadding: CGFloat = 48,
    maxCount: Int = 5,
    lineHeight: CGFloat = 5,
    circleWidthHeight: CGFloat = 16
  ) {
    self.scoreTopPadding = scoreTopPadding
    self.horizontalPadding = horizontalPadding
    self.maxCount = maxCount
    self.lineHeight = lineHeight
    self.circleWidthHeight = circleWidthHeight
  }
}

// MARK: - Gestures..

extension SliderVM {
  func resetButtonOnTapGesture() {
    filledWidth = 0
    nextStepWidth = stepWidth
    stepedCount = 1
    touchEnded = false
  }
}

// MARK: - Detect actions..

extension SliderVM {
  func dragGestureOnChangedAction(transWidth: CGFloat) {
    
    // 오른쪽으로 쭉 이동
    // 만약 한번 때고 다시 이동 시, endWidth 더함
    if transWidth + (touchEnded ? endedWidth : 0) >=
        nextStepWidth - (stepedCount * circleWidthHeight) && stepedCount < CGFloat(maxCount) - 1 {
        filledWidth += stepWidth
        nextStepWidth += stepWidth
        stepedCount += 1
      
    // 왼쪽으로 쭉 이동
    // 만약 한번 때고 다시 이동 시, endWidth 더함
    } else if transWidth + (touchEnded ? endedWidth : 0) <=
                filledWidth - stepWidth + circleWidthHeight && stepedCount >= CGFloat(minCount) {
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
  func viewOnAppearAction(
    screenWidth: CGFloat
  ) {
    setStepWidth(screenWidth: screenWidth)
    nextStepWidth = stepWidth
  }
}

// MARK: - Return funcs..

extension SliderVM {
  func emptyCircleLeadingPadding(_ index: Int) -> CGFloat {
    if index == 0 {
      return -(circleWidthHeight / 2)
      
    } else {
      return stepWidth * CGFloat(index) - circleWidthHeight
    }
  }
  
  func scoreXOffset(_ index: Int) -> CGFloat {
    if index == 1 {
      return -10
      
    } else {
      return stepWidth * CGFloat(index - 1) - 16
    }
  }
}

// MARK: - ETC funcs..

extension SliderVM {
  func setStepWidth(
    screenWidth: CGFloat
  ) {
      stepWidth = (screenWidth - horizontalPadding) / (CGFloat(maxCount) - 1)
  }
}
