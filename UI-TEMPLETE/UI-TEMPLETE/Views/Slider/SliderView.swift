//
//  SliderView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/04.
//

import SwiftUI

struct SliderView: View {
  
  @StateObject var viewModel: SliderVM = SliderVM()
  var horizontalPadding: CGFloat = 48
  
  var body: some View {
    
    VStack(alignment: .leading, spacing: 0) {
      
      Text("stepWidth: \(viewModel.stepWidth)")
      Text("nextStepWidth: \(viewModel.nextStepWidth)")
      Text("filledWidth: \(viewModel.filledWidth)")
      Text("stepedCount: \(viewModel.stepedCount)")
      
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.init(hexCode: "#EAEAEA"))
          .frame(
            maxWidth: .infinity,
            maxHeight: viewModel.height
          )
        
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.init(hexCode: "#FF509B"))
          .frame(
            maxWidth: viewModel.filledWidth,
            maxHeight: viewModel.height
          )
        
        ForEach(0..<viewModel.maxCount, id: \.self) { i in
          Circle()
            .fill(Int(viewModel.stepedCount) > i ?
                  Color.init(hexCode: "#FF509B") : Color.init(hexCode: "#EAEAEA")
            )
            .frame(
              maxWidth: viewModel.circleWidthHeight,
              maxHeight: viewModel.circleWidthHeight
            )
            .padding(.leading, viewModel.emptyCircleLeadingPadding(i))
        }
        
        Circle()
          .fill(Color.init(hexCode: "#FF509B"))
          .frame(
            maxWidth: viewModel.circleWidthHeight,
            maxHeight: viewModel.circleWidthHeight
          )
          .padding(.leading, viewModel.fillCircleLeadingPadding)
          .gesture(
            DragGesture()
              .onChanged { value in
                viewModel.dragGestureOnChangedAction(
                  transWidth: value.translation.width
                )
              }
              .onEnded { value in
                viewModel.dragGestureOnEndedAction()
              }
          )
        
        ForEach(viewModel.minCount...viewModel.maxCount, id: \.self) { i in
          Text("\(i)점")
            .font(.system(size: 14, weight: .medium))
            .offset(x: viewModel.scoreXOffset(i), y: viewModel.scoreYOffset)
        }
      }
      .padding(.top, 20)
      
      Text("Reset")
        .padding()
        .overlay {
          RoundedRectangle(cornerRadius: 12)
            .strokeBorder(Color.gray)
        }
        .onTapGesture {
          viewModel.resetButtonOnTapGesture()
        }
        .padding(.top, 40)
    }
    .padding(.horizontal, 24)
    .onAppear {
      viewModel.viewOnAppearAction(
        screenWidth: UIScreen.screenWidth,
        horizontalPadding: horizontalPadding
      )
    }
  }
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
    SliderView()
  }
}
