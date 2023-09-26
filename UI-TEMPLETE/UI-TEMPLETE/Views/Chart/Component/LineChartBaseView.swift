//
//  LineChartBaseView.swift
//  MOMS-SENSE
//
//  Created by 윤형석 on 2023/09/25.
//

import SwiftUI

struct LineChartBaseView: View {
  @Binding var lineStepSize: CGSize
  @Binding var xTextSize: CGSize
  @Binding var xStepSize: CGSize
  @Binding var yTextSize: CGSize
  @Binding var yStepSize: CGSize
  
  let chartHeight: CGFloat
  let xList: [Int]
  let yList: [Int]
  
  var yToLineSpacing: CGFloat = 4
  var xToLineSpacing: CGFloat = 9
  var lineHeight: CGFloat = 1
  var fontSize: CGFloat = 12
  var fontWeight: Font.Weight = .medium
  
  var body: some View {
    VStack(alignment: .leading, spacing: xToLineSpacing) {
      
      Rectangle()
        .fill(Color.white)
        .frame(height: chartHeight)
        .frame(maxWidth: .infinity, maxHeight: chartHeight)
        .overlay {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(yList.indices, id: \.self) { i in
              
              HStack(alignment: .center, spacing: yToLineSpacing) {
                Text("\(yList[i])")
                  .font(.system(size: 10))
                  .foregroundColor(Color.gray)
                  .getSize(size: $yTextSize)
                
                Rectangle()
                  .fill(Color.gray.opacity(0.3))
                  .frame(height: lineHeight)
              }

              if i != yList.count - 1 {
                Spacer()
                  .getSize(size: $lineStepSize)
              }
            }
          }
        }
      
      HStack(alignment: .center, spacing: 0) {
        ForEach(xList, id: \.self) { x in
          Text("\(x)")
            .font(.system(size: 13, weight: .medium))
            .getSize(size: $xTextSize)

          if xList[xList.count - 1] != x {
            Spacer()
              .getSize(size: $xStepSize)
          }
        }
      }
    }
  }
}

struct LineChartBaseView_Previews: PreviewProvider {
  
  static var previews: some View {
    LineChartBaseView(
      lineStepSize: .constant(CGSize()),
      xTextSize: .constant(CGSize()),
      xStepSize: .constant(CGSize()),
      yTextSize: .constant(CGSize()),
      yStepSize: .constant(CGSize()),
      chartHeight: 300,
      xList: [25, 26, 27, 28, 29, 30],
      yList: [60, 50, 40, 30, 20, 10]
    )
  }
}

