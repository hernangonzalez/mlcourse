import CreateML
import Foundation

// Importing the dataset
let csvFile = Bundle.main.url(forResource: "Position_Salaries", withExtension: "csv")!
var dataTable = try MLDataTable(contentsOf: csvFile)
print(dataTable)

// Remove first column (means same as Level)
dataTable.removeColumn(named: "Position")
print(dataTable)

// Explode Level^2
let level = dataTable["Level"] as MLDataColumn<Int>
(2...4).forEach { power in
    let column = level.map { Int(pow(Double($0), Double(power))) }
    dataTable.addColumn(column, named: "Level_\(power)")
}
print(dataTable)

// Fit SL Regressor with training set
let regressor = try MLLinearRegressor(trainingData: dataTable, targetColumn: "Salary")
print(regressor.trainingMetrics)

//// Predictions
let y_pred = try regressor.predictions(from: dataTable)
print(y_pred)
