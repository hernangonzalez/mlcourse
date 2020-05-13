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
    @Published private(set) var chart: ChartModel = .init(title: "Social Network Purchased")
}

extension ContentModel {

    func loadPredictions() {
        do {
            // Importing the dataset
            let csvFile = Bundle.main.url(forResource: "Social_Network_Ads", withExtension: "csv")!
            var dataTable = try MLDataTable(contentsOf: csvFile)

            // Remove meaningless columns
            dataTable.removeColumn(named: "User ID")
            dataTable.removeColumn(named: "Gender")

            // Pick data columns
            let (trainSet, _) = dataTable.randomSplit(by: 0.75)
            let purchased = (trainSet["Purchased"] as MLDataColumn<Int>)

            // Fit SL Regressor with training set
            let classifier = try MLLogisticRegressionClassifier(trainingData: trainSet, targetColumn: "Purchased")
            print(classifier.trainingMetrics)

            // Predict results
            let predTrain = try classifier.predictions(from: trainSet)
            let predicitons = predTrain.map { $0.intValue! }

            // Scatter values
            let entries = dataTable.chartEntries(x: "Age", y: "EstimatedSalary")
            var matched: [ChartDataEntry] = .init()
            var unmatched: [ChartDataEntry] = .init()
            for index in 0..<purchased.count {
                if predicitons[index] == purchased[index] {
                    matched.append(entries[index])
                } else {
                    unmatched.append(entries[index])
                }
            }

            // Update chart model
            chart.line = .init()
            chart.scatterGreen = matched
            chart.scatterRed = unmatched
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
