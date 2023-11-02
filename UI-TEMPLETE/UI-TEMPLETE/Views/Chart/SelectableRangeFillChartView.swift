//
//  SelectableRangeFillChartView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 11/2/23.
//

import SwiftUI

struct SelectableRangeFillChartView: View {
  let chartType: BloodSugarChartType = .emptyAndBeforeEat
  let unit: String = "(mg/dL)"
  let rightUnit: String? = "점수"
  let leftYList: [Int] = [200, 150, 100, 50, 0]
  let rightYList: [Int]? = [6, 3, 0]
  
//  let xList: [Int] = [25, 26, 27, 28, 29, 30, 31]
//  let xList: [String] = ["아침", "점심", "저녁"]
  let xList: [String] = ["아침", "점심", "저녁", "공복", "자기 전"]
  
//  let bloodSugarValues: [Int] = [140, 60, 50, 250, 130, 120, 150, 70, 120, 140, 60]
//  let bloodSugarValues: [Int] = [140, 60, 50, 60, 100, 50, 80]
  let bloodSugarValues: [Int] = [140, 60, 50, 60, 100]
//  let bloodSugarValues: [Int] = [100, 150, 130]

  let afterEatValues: [Int]? = [1, 3, 5, 1, 3, 5, 3]
//  let afterEatValues: [Int]? = [1, 3, 5]
  
  var circleWidthHeight: CGFloat = 4
  var height: CGFloat = 204
  var width: CGFloat = 300
  
  @State private var leftYTextSize: CGSize = CGSize()
  @State private var rightYTextSize: CGSize = CGSize()
  @State private var yStepSize: CGSize = CGSize()
  @State private var xTextSize: CGSize = CGSize()
  @State private var xStepSize: CGSize = CGSize()
  @State private var bloodSugarXYCoordinates: [(CGFloat, CGFloat)] = []
  @State private var afterEatXYCoordinates: [(CGFloat, CGFloat)] = []
  @State private var selectedXY: (CGFloat, CGFloat) = (0, 0)
  @State private var selectedValue: Int = 0
  @State private var xStepSizeGetCompleted: Bool = false
  
  func circleColor(value: Int) -> Color {
    
    if value >= 141 {
      return Color.rgb(255, 14, 57)
      
    } else if value >= 60 && value <= 140 {
      return Color.rgb(63, 62, 61)
      
    } else {
      return Color.rgb(0, 151, 252)
    }
  }
  
  func isCircleDrawAble(index: Int) -> Bool {
    if bloodSugarValues[index] != -1 {
      return true
      
    } else {
      return false
    }
  }
  
  var body: some View {
    let isDietAndAfterEatChart: Bool = chartType == .dietAndAfterEat
    let isAllChart: Bool = chartType == .all
    
    // MARK: - 혈당, 식단 그래프 둘 다 사용
    
    var xVertexSteps: [CGFloat] {
      var xVertexStart: CGFloat = xTextSize.width / 3
      let xVertexStep: CGFloat = xStepSize.width + 2
      var result: [CGFloat] = []
      
      for i in 0..<bloodSugarValues.count {
        if i == 0 {
          result.append(xVertexStart)
          
        }
        else if  i == (bloodSugarValues.count - 1) {
          xVertexStart += xVertexStep
          result.append(xVertexStart - (isAllChart ? 0 : xTextSize.width / 3))

        }
        else {
          xVertexStart += xVertexStep
          result.append(xVertexStart)
        }
      }
      
      return result
    }
    
    var xLineSteps: [CGFloat] {
      var xVertexStart: CGFloat = xTextSize.width / 3
      let xVertexStep: CGFloat = xStepSize.width + 2
      var result: [CGFloat] = []
      
      for i in 0..<bloodSugarValues.count {
        if i == 0 {
          result.append(xVertexStart + (circleWidthHeight / 2))
          
        } else if  i == (bloodSugarValues.count - 1) {
          xVertexStart += xVertexStep
          result.append(xVertexStart - (isAllChart ? 0 : xTextSize.width / 3))

        } else {
          xVertexStart += xVertexStep
          result.append(xVertexStart + (circleWidthHeight / 2))
        }
      }
      
      return result
    }
    
    // MARK: - 혈당 그래프에서만 사용

    var bloodSugarYLineSteps: [CGFloat] {
      let result: [CGFloat] = bloodSugarValues.map {
        if $0 >= 200 {
          return height - 200 - 2
          
        } else {
          return height - CGFloat($0) - 2
        }
      }
      return result
    }
    
    var bloodSugarYVertexSteps: [CGFloat] {
      let result: [CGFloat] = bloodSugarValues.map {
        if $0 >= 200 {
          return 200 - 2
          
        } else {
          return CGFloat($0) - 2
        }
      }
      return result
    }
    
    // MARK: - 식단 그래프에서만 사용
    
    var dietYLineSteps: [CGFloat] {
      guard let rightYList = rightYList else { return [] }
      guard let afterEatValues = afterEatValues else { return [] }

      let rangeMin: CGFloat = CGFloat(rightYList.min() ?? 0)
      let rangeMax: CGFloat = CGFloat(rightYList.max() ?? 0)

      // 0 = 바꿀 range의 최소값, height = 바꿀 range의 최대값
      return afterEatValues.map { value in
        return height - ((CGFloat(value) - rangeMin) * (height - 0) / (rangeMax - rangeMin) + 0)
      }
    }
    
    var dietYVertexSteps: [CGFloat] {
      guard let rightYList = rightYList else { return [] }
      guard let afterEatValues = afterEatValues else { return [] }

      let rangeMin: CGFloat = CGFloat(rightYList.min() ?? 0)
      let rangeMax: CGFloat = CGFloat(rightYList.max() ?? 0)

      return afterEatValues.map { value in
        return (CGFloat(value) - rangeMin) * (height - 0) / (rangeMax - rangeMin) + 0 - 3
      }
    }
    
    // MARK: - View

    VStack(alignment: .trailing, spacing: 0) {
      
      VStack(alignment: .leading, spacing: 0) {
//        HStack(alignment: .center, spacing: 5) {
//          ForEach(xyCoordinates.indices, id: \.self) { i in
//            Text("\(xyCoordinates[i].0) \(xyCoordinates[i].1))")
//          }
//        }
//        Text("xy: \(selectedXY.0) \(selectedXY.1)")
        
        if isDietAndAfterEatChart {
          
          HStack(alignment: .center, spacing: 0) {
            Text(unit)
            
            Spacer()
              
            if let rightUnit = rightUnit {
              Text(rightUnit)
            }
          }
          .font(.system(size: 8))
          .foregroundStyle(Color.gray)
          .padding(.leading, -25)
          .padding(.trailing, -10)
          
        } else {
          HStack(alignment: .center, spacing: 0) {
            Spacer()

            Text(unit)
              .font(.system(size: 8))
              .foregroundStyle(Color.gray)
            
          }
          .padding(.leading, -25)
        }
      }
      .frame(width: width)
      
      VStack(alignment: .leading, spacing: 0) {
        Rectangle()
          .fill(Color.rgb(255, 226, 238))
          .frame(height: 60 + (circleWidthHeight / 2))
        
        Rectangle()
          .fill(Color.white)
          .frame(height: 80)
        
        Rectangle()
          .fill(Color.rgb(191, 224, 255))
          .frame(height: 60)
      }
      .frame(width: width)
      .overlay {
        if isDietAndAfterEatChart {
          VStack {
            ForEach(0..<5, id: \.self) { i in
              Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
              
              if i != 4 {
                Spacer()
              }
            }
          }
        }
      }
      .overlay(alignment: .topLeading) {
        VStack(alignment: .trailing, spacing: 0) {
          ForEach(leftYList, id: \.self) { value in
            VStack(alignment: .leading, spacing: 0) {
              Text("\(value)")
                .font(.system(size: 10))
                .foregroundStyle(Color.gray)
                .getSize(size: leftYList[0] == value ? $leftYTextSize : .constant(CGSize()))
              
              if leftYList[leftYList.count - 1] != value {
                Spacer()
                  .getSize(size: $yStepSize)
              }
            }
          }
        }
        .offset(x: -leftYTextSize.width - 5)
      }
      .overlay(alignment: .topTrailing) {
        
        VStack(alignment: .trailing, spacing: 0) {
        
          if let rightYList = rightYList {
            ForEach(rightYList, id: \.self) { value in
              VStack(alignment: .leading, spacing: 0) {
                Text("\(value)")
                  .font(.system(size: 10))
                  .foregroundStyle(Color.gray)
                  .getSize(size: $rightYTextSize)
                
                if rightYList[rightYList.count - 1] != value {
                  Spacer()
                }
              }
            }
          }
        }
        .offset(x: rightYTextSize.width + 5)
      }
      .overlay(alignment: .bottomLeading) {
        HStack(alignment: .center, spacing: 0) {
          ForEach(xList, id: \.self) { value in
            HStack(alignment: .center, spacing: 0) {
              Text("\(value)")
                .font(.system(size: 12))
                .getSize(size: $xTextSize)
              
              if xList[xList.count - 1] != value {
                Spacer()
              }
            }
          }
        }
        .offset(x: 0, y: xTextSize.height + 3)
      }
      // For circle step size get
      .overlay(alignment: .bottomLeading) {
          
          HStack(alignment: .center, spacing: 0) {
            
            ForEach(0..<bloodSugarValues.count, id: \.self) { index in
              HStack(alignment: .center, spacing: 0) {
                Circle()
                  .frame(width: circleWidthHeight, height: circleWidthHeight)
                
                if index != bloodSugarValues.count - 1 {
                  Spacer()
                    .getSize(size: $xStepSize)
                }
              }
              .onAppear {
                if index == bloodSugarValues.count - 1 {
                  xStepSizeGetCompleted = true
                }
              }
            }
          }
          .opacity(0)
      }
      .overlay(alignment: .topLeading) {
        
        Path { path in
          path.move(to: CGPoint(x: xLineSteps[0], y: bloodSugarYLineSteps[0]))
          
          guard xLineSteps.count == bloodSugarYLineSteps.count else {
            print("에러문 삽입")
            return
          }
          
          for i in xLineSteps.indices {
            
            if isCircleDrawAble(index: i) {
              path.addLine(to: CGPoint(x: xLineSteps[i], y: bloodSugarYLineSteps[i]))
            }
          }
        }
        .stroke(Color.black, lineWidth: 1)
      }
      .overlay(alignment: .bottomLeading) {
        
        if xStepSizeGetCompleted {
          ZStack(alignment: .bottomLeading) {

            ForEach(bloodSugarValues.indices, id: \.self) { i in
              Circle()
                .fill(circleColor(value: bloodSugarValues[i]))
                .frame(width: circleWidthHeight)
                .padding(.bottom, CGFloat(bloodSugarYVertexSteps[i]))
                .padding(.leading, xVertexSteps[i])
                .background {
                  GeometryReader { geometry in
                    Color.clear
                      .onAppear {
                        bloodSugarXYCoordinates.append(
                          (
                            geometry.frame(in: .local).maxX,
                            height - geometry.frame(in: .local).maxY - 15
                          )
                        )
                      }
                  }
                }
                .onTapGesture {
                  // 위 xyCoordinates.append 될 때, 역순으로 들어감 (?)
                  selectedValue = bloodSugarValues[i]
                  selectedXY = bloodSugarXYCoordinates[bloodSugarValues.count - 1 - i]
                }
                .opacity(isCircleDrawAble(index: i) ? 1 : 0)
            }
          }
        }
      }
      // For show value after circle touch
      .overlay {
        if selectedXY != (0, 0) {
          VStack(alignment: .leading, spacing: 0) {
            Text("\(selectedValue)")
              .font(.system(size: 10))
              .foregroundStyle(Color.white)
              .padding(.vertical, 4)
              .padding(.horizontal, 8)
              .background(Color.black)
              .clipShape(RoundedRectangle(cornerRadius: 4))
              .position(x: selectedXY.0, y: selectedXY.1)
          }
        }
      }
      // 식후 그래프 (식단 기록 + 식후 활동)
      .overlay(alignment: .topLeading) {
        
        if isDietAndAfterEatChart {
          Path { path in
            path.move(to: CGPoint(x: xLineSteps[0], y: dietYLineSteps[0]))
            
            guard xLineSteps.count == bloodSugarYLineSteps.count else {
              print("에러문 삽입")
              return
            }
            
            for i in xLineSteps.indices {
              
              if isCircleDrawAble(index: i) {
                path.addLine(to: CGPoint(x: xLineSteps[i], y: dietYLineSteps[i]))
              }
            }
          }
          .stroke(Color.pink, lineWidth: 1)
        }
      }
      .overlay(alignment: .bottomLeading) {
        
        if isDietAndAfterEatChart {
          if xStepSizeGetCompleted {
            ZStack(alignment: .bottomLeading) {

              ForEach(dietYLineSteps.indices, id: \.self) { i in
                Circle()
                  .fill(Color.pink)
                  .frame(width: circleWidthHeight)
                  .padding(.bottom, dietYVertexSteps[i])
                  .padding(.leading, xVertexSteps[i])
                  .background {
                    GeometryReader { geometry in
                      Color.clear
                        .onAppear {
                          afterEatXYCoordinates.append(
                            (
                              geometry.frame(in: .local).maxX,
                              height - geometry.frame(in: .local).maxY - 15
                            )
                          )
                        }
                    }
                  }
                  .onTapGesture {
                    // 위 xyCoordinates.append 될 때, 역순으로 들어감 (?)
                    guard let afterEatValues = afterEatValues else { return }
                    selectedValue = afterEatValues[i]
                    selectedXY = afterEatXYCoordinates[afterEatValues.count - 1 - i]
                  }
                  .opacity(isCircleDrawAble(index: i) ? 1 : 0)
              }
            }
          }
        }
      }
    }
  }
}

#Preview {
    SelectableRangeFillChartView()
}
