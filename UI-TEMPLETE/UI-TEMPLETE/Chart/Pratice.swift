//
//  Pratice.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/07.
//

import SwiftUI
import DGCharts

struct Pratice: View {
    var body: some View {
        ChartView()
    }
}

struct Pratice_Previews: PreviewProvider {
    static var previews: some View {
        Pratice()
    }
}

let yValues: [ChartDataEntry] = [
  ChartDataEntry(x: 25, y: 130),
  ChartDataEntry(x: 26, y: 100),
  ChartDataEntry(x: 27, y: 136),
  ChartDataEntry(x: 28, y: 150),
  ChartDataEntry(x: 29, y: 146),
  ChartDataEntry(x: 30, y: 0)

]

struct ChartView: UIViewRepresentable {
  
  func makeUIView(context: Context) -> some UIView {
    let chartView = LineChartView()
//    chartView.backgroundColor = .systemBlue
    chartView.drawGridBackgroundEnabled = true
    chartView.gridBackgroundColor = .gray
    let set1 = LineChartDataSet(entries: yValues)
    let data = LineChartData(dataSet: set1)
    chartView.data = data

    chartView.rightAxis.enabled = false
    
    let leftAxix = chartView.leftAxis
    leftAxix.axisMinimum = 0
    leftAxix.axisMaximum = 200
    leftAxix.granularity = 50

    leftAxix.labelFont = .systemFont(ofSize: 16, weight: .bold)
    leftAxix.gridLineWidth = 0
    leftAxix.labelPosition = .outsideChart
    chartView.autoScaleMinMaxEnabled = false
    
    return chartView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
    ()
  }
}
