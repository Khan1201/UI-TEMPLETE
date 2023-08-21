//
//  InsideRangeLineChartView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/18.
//

import SwiftUI

struct InsideRangeLineChartView: View {
  @State private var xTextSize: CGSize = CGSize()
  @State private var yTextSize: CGSize = CGSize()
  @State private var xStepSize: CGSize = CGSize()
  @State private var yStepSize: CGSize = CGSize()
  @State private var lineStepSize: CGSize = CGSize()
//  @State private var minMaxIdx: (Int, Int) = (0, 0)
  
  let xList: [Int] = [0, 10, 20, 30, 40]
  let yList: [Int] = [80, 75, 70, 65, 60]
  let width: CGFloat = 280
  let height: CGFloat = 200
  let vertexWidthHeight: CGFloat = 4
  
  let minValues: [CGFloat] = [
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
  
  let maxValues: [CGFloat] = [
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
    75.9
  ]
  
  let values: [CGFloat] = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    65.0,
    65.4,
    65.6,
    65.8,
    66,
    68,
    0,
    70,
    65,
    68,
    70,
    72,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ]
  
  var body: some View {
    var convertedMinValues: [CGFloat] {
      let rangeMin: CGFloat = CGFloat(yList.min() ?? 0)
      let rangeMax: CGFloat = CGFloat(yList.max() ?? 0)
      
      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return minValues.map { value in
        (value - rangeMin) * (CGFloat(height) - 0) / (rangeMax - rangeMin) + 0
      }
    }
    
    var convertedMaxValues: [CGFloat] {
      let rangeMin: CGFloat = CGFloat(yList.min() ?? 0)
      let rangeMax: CGFloat = CGFloat(yList.max() ?? 0)
      
      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return maxValues.map { value in
        (value - rangeMin) * (CGFloat(height) - 0) / (rangeMax - rangeMin) + 0
      }
    }
    
    var convertedValues: [CGFloat] {
      let rangeMin: CGFloat = CGFloat(yList.min() ?? 0)
      let rangeMax: CGFloat = CGFloat(yList.max() ?? 0)
      
      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return values.map { value in
        if value == 0 {
          return 0
          
        } else {
          return (value - rangeMin) * (CGFloat(height) - 0) / (rangeMax - rangeMin) + 0
        }
      }
    }
    
    var valueSteps: [CGFloat] {
      var stepSum: Int = 0
      let step: Int = Int(width) / maxValues.count
      
      return maxValues.map { value in
        if maxValues.first == value {
          return CGFloat(stepSum)
          
        } else {
          stepSum += step
          return CGFloat(stepSum)
        }
      }
    }
    
    FiveLineChartBaseView(
      lineStepSize: $lineStepSize,
      xTextSize: $xTextSize,
      xStepSize: $xStepSize,
      yTextSize: $yTextSize,
      yStepSize: $yStepSize,
      width: width,
      height: height,
      xList: xList,
      yList: yList
    )
    .overlay(alignment: .bottom) {
      Path { path in
        path.move(to: CGPoint(x: 0, y: height - convertedMinValues[0]))
        
        for i in 1..<minValues.count {
          path.addLine(to: CGPoint(x: valueSteps[i], y: height - convertedMinValues[i]))
        }
        
        path.addLine(to: CGPoint(x: valueSteps[valueSteps.count - 1], y: height - convertedMaxValues[convertedMaxValues.count - 1]))
        
        for j in (0..<maxValues.count).reversed() {
          path.addLine(to: CGPoint(x: valueSteps[j], y: height - convertedMaxValues[j]))
        }
      }
      .fill(Color.red.opacity(0.3))
    }
    .overlay(alignment: .bottom) {
      var vertexIdx: [Int] = []

      Path { path in
        var count = 0
        
        for i in 1..<convertedValues.count {
          if convertedValues[i] != 0 {
            if count == 0 {
              path.move(to: CGPoint(x: valueSteps[i], y: height - convertedValues[i]))
              vertexIdx.append(i)

            } else {
              path.addLine(to: CGPoint(x: valueSteps[i], y: height - convertedValues[i]))
              vertexIdx.append(i)
            }
            
            count += 1
          }
        }
      }
      .stroke(Color.red.opacity(0.5))
      .overlay(alignment: .bottomLeading) {
        ZStack(alignment: .bottomLeading) {
          ForEach(vertexIdx, id: \.self) { i in
              Circle()
                .fill(Color.pink)
                .frame(width: vertexWidthHeight, height: vertexWidthHeight)
                .padding(.bottom, convertedValues[i] - vertexWidthHeight / 2)
                .padding(.leading, valueSteps[i] - vertexWidthHeight / 2)
          }
        }
      }
    }
  }
}

struct InsideRangeLineChartView_Previews: PreviewProvider {
  static var previews: some View {
    InsideRangeLineChartView()
  }
}
