//
//  ContentModel.swift
//  regression
//
//  Created by Hernan G. Gonzalez on 27/12/2019.
//  Copyright © 2019 Indeba. All rights reserved.
//

import Foundation
import Charts
import CreateML

class ContentModel: ObservableObject {
    @Published private(set) var chart: ChartModel = .init()
}

extension ContentModel {

    func loadPredictions() {
        do {
            // Importing the dataset
            let csvFile = Bundle.main.url(forResource: "Position_Salaries", withExtension: "csv")!
            var dataTable = try MLDataTable(contentsOf: csvFile)

            // Remove first column (means same as Level)
            dataTable.removeColumn(named: "Position")
            let levels = dataTable["Level"] as MLDataColumn<Int>

            // Fit SL Regressor with training set
            let regressor = try MLRandomForestRegressor(trainingData: dataTable, targetColumn: "Salary")
            print(regressor.trainingMetrics)

            // Predict results
            let predTrain = try regressor.predictions(from: dataTable)

            // Prediction line
            var line: [ChartDataEntry] = .init()
            (0 ..< levels.count).forEach { index in
                let level = levels[index]
                let prediction = predTrain[index].doubleValue ?? -1
                let entry = ChartDataEntry(x: Double(level), y: prediction.rounded())
                line.append(entry)
            }

            // Scatter exact values
            let scatterTrain = dataTable.chartEntries(x: "Level", y: "Salary")

            // Update chart model
            chart.line = line
            chart.scatterRed = scatterTrain
        } catch {
            print(error)
        }
    }
}

private extension MLDataTable {
    func chartEntries(x: String, y: String) -> [ChartDataEntry] {
        let columnX = self[x] as MLDataColumn<Int>
        let columnY = self[y] as MLDataColumn<Int>

        var entries: [ChartDataEntry] = .init()
        for i in 0..<columnX.count {
            let entry = ChartDataEntry(x: Double(columnX[i]),
                                       y: Double(columnY[i]))
            entries.append(entry)
        }

        return entries
    }
}
