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
            let csvFile = Bundle.main.url(forResource: "Salary_Data", withExtension: "csv")!
            let dataTable = try MLDataTable(contentsOf: csvFile)
            print(dataTable)

            // Split train and test set
            let (trainSet, testSet) = dataTable.randomSplit(by: 2.0/3.0, seed: 0)
            print(trainSet)
            print(testSet)

            // Fit SL Regressor with training set
            let regressor = try MLLinearRegressor(trainingData: trainSet, targetColumn: "Salary")
            print(regressor.trainingMetrics)

            // Predict results
            let predTrain = try regressor.predictions(from: trainSet)

            // Prediction line
            var line: [ChartDataEntry] = .init()
            let years = trainSet["YearsExperience"] as MLDataColumn<Double>
            for index in 0 ..< years.count {
                let experience = years[index]
                let prediction = predTrain[index].doubleValue ?? -1
                let entry = ChartDataEntry(x: experience, y: prediction.rounded())
                line.append(entry)
            }

            // Scatter exact values
            let scatterTrain = trainSet.chartEntries(x: "YearsExperience", y: "Salary")
            let scatterTest = testSet.chartEntries(x: "YearsExperience", y: "Salary")

            // Update chart model
            chart.line = line
            chart.scatterRed = scatterTrain
            chart.scatterGreen = scatterTest
        } catch {
            print(error)
        }
    }
}

private extension MLDataTable {
    func chartEntries(x: String, y: String) -> [ChartDataEntry] {
        let columnX = self[x] as MLDataColumn<Double>
        let columnY = self[y] as MLDataColumn<Double>

        var entries: [ChartDataEntry] = .init()
        for i in 0..<columnX.count {
            let entry = ChartDataEntry(x: columnX[i],
                                       y: columnY[i])
            entries.append(entry)
        }

        return entries
    }
}
