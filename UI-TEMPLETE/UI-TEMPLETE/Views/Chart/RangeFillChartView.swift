//
//  RangeFillChartView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/11.
//

import SwiftUI

struct RangeFillChartView: View {
  let yList: [Int] = [200, 150, 100, 50, 0]
  let xList: [Int] = [25, 26, 27, 28, 29, 30]
  let chartValues: [RangeFillChartValue] = [.init(value: 160), .init(value: 180), .init(value: 200), .init(value: 200), .init(value: 150), .init(value: 200)]
  
  @State private var yTextSize: CGSize = CGSize()
  @State private var yStepSize: CGSize = CGSize()
  @State private var xTextSize: CGSize = CGSize()
  @State private var xStepSize: CGSize = CGSize()
  @State private var rectangleSize: CGSize = CGSize()
  
  var body: some View {
    let width: CGFloat = 280
    let height: CGFloat = 200
    
    var xVertexes: [CGFloat] {
      var xVertexStart: CGFloat = 0
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

      result.append(result[result.count - 1]) // 마지막에 꼭짓점에서 초기 y 값으로 찍으므로, append
      return result
    }
//
    var yVertexes: [CGFloat] {
      var result: [CGFloat] = chartValues.map {
        
        // +5를 해줘야 점 중앙에 위치함
        height - CGFloat($0.value) + 5
      }
      result.append(height) // 마지막에 꼭짓점에서 초기 y 값으로 찍으므로, append
      return result
    }
    
    // 범위 표시가 y수치의 중앙에 위치해야하므로 (ex - 150을 표현할려면 150의 중앙에 위치해야함) y수치 height의 2/1을 빼고 기존 height에 비율 계산
    let graphHeightRatio: CGFloat = (height - (yTextSize.height / 2)) / height
    
    VStack(alignment: .trailing, spacing: 0) {
      
      Rectangle()
        .fill(Color.red.opacity(0.1))
        .frame(width: width, height: height)
        .coordinateSpace(name: "base")
        .overlay(alignment: .topLeading) {
          let xVertexes = xVertexes
          let yVertexes = yVertexes
          
          Path { path in
            path.move(to: CGPoint(x: 0, y: height))

            path.addLine(to: CGPoint(x: xVertexes[0], y: yVertexes[0]))
            path.addLine(to: CGPoint(x: xVertexes[1], y: yVertexes[1]))
            path.addLine(to: CGPoint(x: xVertexes[2], y: yVertexes[2]))
            path.addLine(to: CGPoint(x: xVertexes[3], y: yVertexes[3]))
            path.addLine(to: CGPoint(x: xVertexes[4], y: yVertexes[4]))
            path.addLine(to: CGPoint(x: xVertexes[5], y: yVertexes[5]))
            path.addLine(to: CGPoint(x: xVertexes[6], y: yVertexes[6]))

            path.addLine(to: CGPoint(x: 0, y: 200))

//              path.move(to: CGPoint(x: 5, y: 200))
//              path.addLine(to: CGPoint(x: 5, y: 100))
//              path.addLine(to: CGPoint(x: 60, y: 50))
//              path.addLine(to: CGPoint(x: 115, y: 0))
//              path.addLine(to: CGPoint(x: 170, y: 0))
//              path.addLine(to: CGPoint(x: 225, y: 50))
//              path.addLine(to: CGPoint(x: 280, y: 60))
//              path.addLine(to: CGPoint(x: 280, y: 200))
//              path.addLine(to: CGPoint(x: 5, y: 200))
          }
          .fill(Color.red.opacity(0.3))
        }
        .overlay(alignment: .bottom) {
          Rectangle()
            .fill(Color.white)
            .frame(height: yStepSize.height / 2)
            .offset(y: -yStepSize.height * 1.5 - (yTextSize.height * 2.5))
        }
      
        .overlay(alignment: .topLeading) {
          VStack(alignment: .trailing, spacing: 0) {
            ForEach(yList, id: \.self) { value in
              VStack(alignment: .leading, spacing: 0) {
                Text("\(value)")
                  .font(.system(size: 12, weight: .medium))
                  .getSize(size: yList[0] == value ? $yTextSize : .constant(CGSize()))
                
                if yList[yList.count - 1] != value {
                  Spacer()
                    .getSize(size: $yStepSize)
                }
              }
            }
          }
          .offset(x: -yTextSize.width - 5)
        }
        .overlay(alignment: .bottomLeading) {
          HStack(alignment: .center, spacing: 0) {
            ForEach(xList, id: \.self) { value in
              HStack(alignment: .center, spacing: 0) {
                Text("\(value)")
                  .font(.system(size: 12, weight: .medium))
                  .getSize(size: $xTextSize)
                
                if xList[xList.count - 1] != value {
                  Spacer()
                    .getSize(size: $xStepSize)
                }
              }
            }
          }
          .padding(.horizontal, -5)
          .offset(x: 0, y: xTextSize.height + 3)
        }
        .overlay(alignment: .bottomLeading) {
          
          HStack(alignment: .bottom, spacing: 0) {
            ForEach(chartValues, id: \.id) { chartValue in
              Circle()
                .frame(width: 5)
                .padding(.bottom, CGFloat(chartValue.value) * graphHeightRatio)

              if chartValues[chartValues.count - 1].id != chartValue.id {
                Spacer()
              }
            }
          }
          .padding(.trailing, 5)
        }
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
          .stroke(Color.black, lineWidth: 1)
        }

      VStack(alignment: .leading, spacing: 0) {
        Text("\(yStepSize.height + (yTextSize.height * 2) - (yTextSize.height / 2))")
        Text("\(yTextSize.height / 2)")
        Text("\(xStepSize.width + xTextSize.width)")
      }
      .offset(y: 50)
    }
    .frame(width: width, height: height)
  }
}

struct RangeFillChartView_Previews: PreviewProvider {
  static var previews: some View {
    RangeFillChartView()
  }
}

struct RangeFillChartValue: Identifiable {
  let id = UUID()
  let value: Int
}
