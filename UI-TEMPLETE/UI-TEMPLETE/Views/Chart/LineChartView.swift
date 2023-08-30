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
  
  let xList: [Int] = [25, 26, 27, 28, 29, 30]
  let yList: [Int] = [5, 4, 3, 2, 1]
  let chartValues: [LineChartValue] = [.init(value: 3), .init(value: 4.5), .init(value: 3.8), .init(value: 3.1), .init(value: 2.8), .init(value: 2.7)]
  
  let width: CGFloat = 280
  let height: CGFloat = 200
  let circleSize: CGSize = CGSize(width: 5, height: 5)
  
  var body: some View {
    
    var xVertexes: [CGFloat] {
      
      // Cicle 중간에 path 찍기위해 시작점은 circle width / 2
      var xVertexStart: CGFloat = circleSize.width / 2
      
      // x축 간의 간격 + x축 아이템 width(x축 아이템 width 반틈 + x축 아이템 width 반틈)
      let xVertexStep: CGFloat = xStepSize.width + (xTextSize.width / 2 * 2)
      var result: [CGFloat] = []
      
      for i in 0..<chartValues.count {
        if i == 0 {
          result.append(xVertexStart)
          
        } else {
          xVertexStart += xVertexStep
          result.append(xVertexStart)
        }
      }
      
      return result
    }
    
    var yVertexes: [CGFloat] {
      
      // path를 그릴때 CGPoint 첫 위치인 (0,0)은 좌측 상단부터 기준으로 하므로, heignt - 로 시작한다.
      // 각 line 단계별 height * 표현할 value (line 단계별 height 를 지나간 개수로 파악하면 되므로, 표현할 value - 1을 한다)
      // * 1.055 -> 3, 4, 5 이렇게 값이 증가할 때, line 자체의 height의 크기에 영향을 받으므로(표현할 value가 2이면 1개의 line height에 영향을 받았고, value가 4이면 3개의 line height에 영향을 받음) 비율을 맞춰준다.
      // + 2.5 -> 원형 height의 2/1을 더해준다.
      var result: [CGFloat] = chartValues.map { height - (lineStepSize.height * (CGFloat($0.value - 1)) * 1.055 + 2.5)} // +4를 해줘야 점 중앙에 위치함
      result.append(height) // 마지막에 꼭짓점에서 초기 y 값으로 찍으므로, append
      return result
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
    .overlay(alignment: .topLeading) {
      let xVertexes = xVertexes
      let yVertexes = yVertexes
      
      Path { path in
        path.move(to: CGPoint(x: xVertexes[0], y: yVertexes[0]))
        path.addLine(to: CGPoint(x: xVertexes[1], y: yVertexes[1]))
        path.addLine(to: CGPoint(x: xVertexes[2], y: yVertexes[2]))
        path.addLine(to: CGPoint(x: xVertexes[3], y: yVertexes[3]))
        path.addLine(to: CGPoint(x: xVertexes[4], y: yVertexes[4]))
        path.addLine(to: CGPoint(x: xVertexes[5], y: yVertexes[5]))
      }
      .stroke(Color.red.opacity(0.4), lineWidth: 2)
    }
    .overlay(alignment: .bottomLeading) {
      
      HStack(alignment: .bottom, spacing: 0) {
        ForEach(chartValues, id: \.id) { chartValue in
          Circle()
            .fill(Color.pink)
            .frame(width: circleSize.width, height: circleSize.height)
            .padding(.bottom, (lineStepSize.height * (CGFloat(chartValue.value - 1)) * 1.055))
          
          if chartValues[chartValues.count - 1].id != chartValue.id {
            Spacer()
          }
        }
      }
    }
    .overlay(alignment: .bottom) {
      VStack(alignment: .leading, spacing: 10) {
        Text("yStepSize: \(yStepSize.height)")
      }
      .offset(y: 100)
    }
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
