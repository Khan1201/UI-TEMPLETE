//
//  FiveLineChartBaseView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/18.
//

import SwiftUI

struct FiveLineChartBaseView: View {
  @Binding var lineStepSize: CGSize
  @Binding var xTextSize: CGSize
  @Binding var xStepSize: CGSize
  @Binding var yTextSize: CGSize
  @Binding var yStepSize: CGSize
  
  let width: CGFloat
  let height: CGFloat
  let xList: [Int]
  let yList: [Int]
  
  var lineHeight: CGFloat = 3
  var fontSize: CGFloat = 12
  var fontWeight: Font.Weight = .medium
  
  var body: some View {
    Rectangle()
      .fill(Color.white)
      .frame(width: width, height: height)
      .overlay {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(0...4, id: \.self) { i in
            Rectangle()
              .fill(Color.gray.opacity(0.3))
              .frame(height: lineHeight)
            
            if i != 4 {
              Spacer()
                .getSize(size: $lineStepSize)
            }
          }
        }
      }
      .overlay(alignment: .bottom) {
        HStack(alignment: .center, spacing: 0) {
          ForEach(xList, id: \.self) { x in
            Text("\(x)")
              .font(.system(size: fontSize, weight: fontWeight))
              .getSize(size: $xTextSize)
            
            if xList[xList.count - 1] != x {
              Spacer()
                .getSize(size: $xStepSize)
            }
          }
        }
        .padding(.horizontal, -5)
        .offset(y: xTextSize.height + 7)
      }
      .overlay(alignment: .topLeading) {
        VStack(alignment: .leading, spacing: 0) {
          ForEach(yList, id: \.self) { y in
            Text("\(y)")
              .font(.system(size: 12, weight: .medium))
              .getSize(size: $yTextSize)
            
            if yList[yList.count - 1] != y {
              Spacer()
                .getSize(size: $yStepSize)
            }
          }
        }
        .padding(.vertical, -5)
        .offset(x: -yTextSize.width - 7)
      }
  }
  
  struct FiveLineChartBaseView_Previews: PreviewProvider {
    
    static var previews: some View {
      FiveLineChartBaseView(
        lineStepSize: .constant(CGSize()),
        xTextSize: .constant(CGSize()),
        xStepSize: .constant(CGSize()),
        yTextSize: .constant(CGSize()),
        yStepSize: .constant(CGSize()),
        width: 280,
        height: 200,
        xList: [25, 26, 27, 28, 29, 30],
        yList: [5, 4, 3, 2, 1]
      )
    }
  }
}
