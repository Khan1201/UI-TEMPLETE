//
//  SliderView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/04.
//

import SwiftUI

struct SliderView: View {
  
  @StateObject var viewModel: SliderVM = SliderVM()
  @State private var scoreTextSize: CGSize = CGSize()
  
  var body: some View {
    let sliderHeight: CGFloat = viewModel.circleWidthHeight + scoreTextSize.height + viewModel.scoreTopPadding
    
    VStack(alignment: .leading, spacing: 30) {
      
      VStack(alignment: .leading, spacing: 0) {
        Text("stepWidth: \(viewModel.stepWidth)")
        Text("nextStepWidth: \(viewModel.nextStepWidth)")
        Text("filledWidth: \(viewModel.filledWidth)")
        Text("stepedCount: \(viewModel.stepedCount)")
      }
      
      VStack(alignment: .leading, spacing: 0) {
        ZStack(alignment: .leading) {
          RoundedRectangle(cornerRadius: 12)
            .fill(Color.init(hexCode: "#EAEAEA"))
            .frame(
              maxWidth: .infinity,
              maxHeight: viewModel.lineHeight
            )
          
          RoundedRectangle(cornerRadius: 12)
            .fill(Color.init(hexCode: "#FF509B"))
            .frame(
              maxWidth: viewModel.filledWidth,
              maxHeight: viewModel.lineHeight
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
              .getSize(size: $scoreTextSize)
          }
        }
      }
      .frame(maxHeight: sliderHeight, alignment: .top)
      .onAppear {
        viewModel.viewOnAppearAction(
          screenWidth: UIScreen.screenWidth
        )
      }
      
      Text("Reset")
        .padding()
        .overlay {
          RoundedRectangle(cornerRadius: 12)
            .strokeBorder(Color.gray)
        }
        .onTapGesture {
          viewModel.resetButtonOnTapGesture()
        }
    }
    .padding(.horizontal, 24)
  }
}

struct SliderView_Previews: PreviewProvider {
  static var previews: some View {
    SliderView()
  }
}
