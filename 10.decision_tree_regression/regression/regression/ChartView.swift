//
//  ChartView.swift
//  regression
//
//  Created by Hernan G. Gonzalez on 27/12/2019.
//  Copyright © 2019 Indeba. All rights reserved.
//

import SwiftUI
import Charts

struct ChartModel {
    var line: [ChartDataEntry] = .init()
    var scatterRed: [ChartDataEntry] = .init()
    var scatterGreen: [ChartDataEntry] = .init()
}

struct ChartView {
    let model: ChartModel
}

// MARK: - UIViewRepresentable
extension ChartView: NSViewRepresentable {
    func makeNSView(context: NSViewRepresentableContext<ChartView>) -> CombinedChartView {
        let view = CombinedChartView()
        view.chartDescription?.text = "Level vs Salary"
        return view
    }

    func updateNSView(_ nsView: CombinedChartView, context: NSViewRepresentableContext<ChartView>) {
        let line = LineChartDataSet(entries: model.line)
        line.colors = [.blue]
        line.drawCirclesEnabled = false
        line.drawValuesEnabled = false

        let scatterRed = ScatterChartDataSet(entries: model.scatterRed)
        scatterRed.colors = [.red]
        let scatterGreen = ScatterChartDataSet(entries: model.scatterGreen)
        scatterGreen.colors = [.green]

        let data = CombinedChartData()
        data.lineData = LineChartData(dataSet: line)
        data.scatterData = ScatterChartData(dataSets: [scatterRed, scatterGreen])
        data.setDrawValues(false)

        nsView.data = data
    }
}
