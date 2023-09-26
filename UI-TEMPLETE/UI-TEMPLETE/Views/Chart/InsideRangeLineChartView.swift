//
//  InsideRangeLineChartView.swift
//  MOMS-SENSE
//
//  Created by 윤형석 on 2023/09/25.
//

import SwiftUI

struct InsideRangeLineChartView: View {
  @State private var xTextSize: CGSize = CGSize()
  @State private var yTextSize: CGSize = CGSize()
  @State private var xStepSize: CGSize = CGSize()
  @State private var yStepSize: CGSize = CGSize()
  @State private var lineStepSize: CGSize = CGSize()
  @State private var lineChartBaseViewSize: CGSize = CGSize()
  
  var xList: [Int] = [0, 10, 20, 30, 40]
  var yList: [Int] = [80, 75, 70, 65, 60, 55]
  var width: CGFloat = 340
  var chartHeight: CGFloat = 150
  var vertexWidthHeight: CGFloat = 5
  var yToLineSpacing: CGFloat = 4
  var xToLineSpacing: CGFloat = 9
  let horizontalBaseLineHeight: CGFloat = 1
  
  let minValues: [Double] = [
    60.0,
    60.0,
    60.1,
    60.1,
    60.2,
    60.2,
    60.2,
    60.3,
    60.3,
    60.4,
    60.4,
    60.5,
    60.5,
    60.9,
    61.3,
    61.7,
    62.1,
    62.5,
    62.9,
    63.3,
    63.7,
    64.1,
    64.5,
    64.9,
    65.3,
    65.7,
    66.1,
    66.5,
    66.9,
    67.3,
    67.7,
    68.1,
    68.5,
    68.9,
    69.3,
    69.7,
    70.1,
    70.5,
    70.9,
    71.3
  ]
  
  let maxValues: [Double] = [
    60.0,
    60.2,
    60.3,
    60.5,
    60.7,
    60.8,
    61.0,
    61.2,
    61.3,
    61.5,
    61.7,
    61.8,
    62.0,
    62.5,
    63.0,
    63.5,
    64.1,
    64.6,
    65.1,
    65.6,
    66.1,
    66.6,
    67.1,
    67.7,
    68.2,
    68.7,
    69.2,
    69.7,
    70.2,
    70.7,
    71.2,
    71.8,
    72.3,
    72.8,
    73.3,
    73.8,
    74.3,
    74.8,
    75.4,
    75.8
  ]
  
  let values: [Double] = [
    60,
    55,
    0,
    55,
    0,
    0,
    55,
    0,
    0,
    60,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    65,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    55,
    60,
    65,
    70,
    75,
    80,
    0,
    0,
    0,
    0,
    0,
    0,
    55
  ]
  
  var body: some View {
    let chartVStartPadding: CGFloat = xTextSize.height + xToLineSpacing + vertexWidthHeight
    let chartHStartPadding: CGFloat = yTextSize.width + yToLineSpacing
    let valueRatio: CGFloat = 0.926
    
    var convertedMinValues: [CGFloat] {
      let rangeMin: CGFloat = CGFloat(yList.min() ?? 0)
      let rangeMax: CGFloat = CGFloat(yList.max() ?? 0)
      
      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return minValues.map { value in
        (value - rangeMin) * (chartHeight - 0) / (rangeMax - rangeMin) + 0
      }
    }
    
    var convertedMaxValues: [CGFloat] {
      let rangeMin: CGFloat = CGFloat(yList.min() ?? 0)
      let rangeMax: CGFloat = CGFloat(yList.max() ?? 0)
      
      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return maxValues.map { value in
        (value - rangeMin) * (chartHeight - 0) / (rangeMax - rangeMin) + 0
      }
    }
    
    var convertedValues: [CGFloat] {
      let rangeMin: CGFloat = CGFloat(yList.min() ?? 0) - 0.1
      let rangeMax: CGFloat = CGFloat(yList.max() ?? 0)

      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return values.map { value in
        if value == 0 {
          return 0

        } else {
          return (value - rangeMin) * (chartHeight - 0) / (rangeMax - rangeMin) + 0
        }
      }
    }
    
    var valueSteps: [CGFloat] {
      var stepSum: CGFloat = chartHStartPadding
      let step: CGFloat = (lineChartBaseViewSize.width - (chartHStartPadding)) / CGFloat(maxValues.count - 1)
      
      return maxValues.map { value in
        if maxValues.first == value {
          return CGFloat(stepSum)
          
        } else {
          stepSum += step
          return CGFloat(stepSum)
        }
      }
    }
    
    LineChartBaseView(
      lineStepSize: $lineStepSize,
      xTextSize: $xTextSize,
      xStepSize: $xStepSize,
      yTextSize: $yTextSize,
      yStepSize: $yStepSize,
      chartHeight: chartHeight,
      xList: xList,
      yList: yList
    )
    .getSize(size: $lineChartBaseViewSize)
    .overlay(alignment: .bottom) {
      Path { path in
        path.move(
          to:
            CGPoint(
              x: chartHStartPadding,
              y: chartHeight - (convertedMinValues[0] + (yTextSize.height / 2)) * valueRatio
            )
        )
        for i in 0..<minValues.count {
          path.addLine(to:
                        CGPoint(
                          x: valueSteps[i],
                          y: chartHeight - (convertedMinValues[i] + (yTextSize.height / 2)) * valueRatio
                        )
          )
        }
        
        path.addLine(to:
                      CGPoint(
                        x: valueSteps[valueSteps.count - 1],
                        y: chartHeight - convertedMaxValues[convertedMaxValues.count - 1]
                      )
        )
        
        for j in (0..<maxValues.count).reversed() {
          path.addLine(to:
                        CGPoint(
                          x: valueSteps[j],
                          y: chartHeight - (convertedMaxValues[j] + (yTextSize.height / 2)) * valueRatio
                        )
          )
        }
      }
      .fill(Color.rgb(241, 226, 255))
    }
    .overlay(alignment: .bottom) {
      var vertexIdx: [Int] = []
      
      Path { path in
        var count = 0
        
        for i in 0..<convertedValues.count {
          if convertedValues[i] != 0 {
            if count == 0 {
              path.move(to:
                          CGPoint(
                            x: valueSteps[i],
                            y: chartHeight - (convertedValues[i] + (yTextSize.height / 2)) * valueRatio
                          )
              )
              vertexIdx.append(i)
              
            } else {
              path.addLine(to:
                            CGPoint(
                              x: valueSteps[i],
                              y: chartHeight - (convertedValues[i] + (yTextSize.height / 2)) * valueRatio
                            )
              )
              vertexIdx.append(i)
            }
            
            count += 1
          }
        }
      }
      .stroke(Color.rgb(181, 106, 255).opacity(0.4), lineWidth: 2)
      .overlay(alignment: .bottomLeading) {
        ZStack(alignment: .bottomLeading) {
          ForEach(vertexIdx, id: \.self) { i in
            Circle()
              .fill(Color.rgb(181, 106, 255))
              .frame(width: vertexWidthHeight, height: vertexWidthHeight)
              .padding(.bottom, (chartVStartPadding + convertedValues[i]) * valueRatio)
              .padding(.leading, valueSteps[i] - vertexWidthHeight / 2)
          }
        }
      }
    }
    .padding(.horizontal, 20)
  }
}

struct InsideRangeLineChartView_Previews: PreviewProvider {
  static var previews: some View {
    InsideRangeLineChartView()
  }
}

