//
//  LineChartView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/17.
//

import SwiftUI

struct LineChartView: View {
  @State private var xTextSize: CGSize = CGSize()
  @State private var yTextSize: CGSize = CGSize()
  @State private var xStepSize: CGSize = CGSize()
  @State private var yStepSize: CGSize = CGSize()
  @State private var lineStepSize: CGSize = CGSize()
  @State private var lineChartBaseViewSize: CGSize = CGSize()

  let xList: [Int] = [1, 2, 3, 4, 5]
  let yList: [Int] = [10, 20, 30, 40, 50].reversed()
  let values: [Int] = [15, 25, 30, 35, 45, 50, 30, 40, 50, 20]
  
  var width: CGFloat = 340
  var chartHeight: CGFloat = 150
  var vertexWidthHeight: CGFloat = 5
  var yToLineSpacing: CGFloat = 4
  var xToLineSpacing: CGFloat = 9
  let horizontalBaseLineHeight: CGFloat = 1
  
  var body: some View {
    let chartVStartPadding: CGFloat = xTextSize.height + xToLineSpacing + vertexWidthHeight
    let chartHStartPadding: CGFloat = yTextSize.width + yToLineSpacing
    let valueRatio: CGFloat = 0.926
    
    var convertedValues: [CGFloat] {
      
      /// -1 하지 않으면 범위의 젤 작은값이 들어오면 보이지 않는다.
      let rangeMin: CGFloat = CGFloat(yList.min() ?? 0) - 1
      let rangeMax: CGFloat = CGFloat(yList.max() ?? 0)

      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return values.map { value in
        if value == 0 {
          return 0

        } else {
          return (CGFloat(value) - rangeMin) * (chartHeight - 0) / (rangeMax - rangeMin) + 0
        }
      }
    }
    
    var valueSteps: [CGFloat] {
      var stepSum: CGFloat = chartHStartPadding
      let step: CGFloat = (lineChartBaseViewSize.width - (chartHStartPadding)) / CGFloat(values.count - 1)
      
      return values.map { value in
        if values.first == value {
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
    .padding(.horizontal, 24) // test
  }
  
  struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
      LineChartView()
    }
  }
}

struct LineChartValue: Identifiable {
  let id = UUID()
  let value: Float
}
