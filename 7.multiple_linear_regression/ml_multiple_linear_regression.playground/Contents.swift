import CreateML
import Foundation

// Importing the dataset
let csvFile = Bundle.main.url(forResource: "50_Startups", withExtension: "csv")!
var dataTable = try MLDataTable(contentsOf: csvFile)
print(dataTable)

// Encoding categories (Feature, onehot)
// Is this needed with CoreML?

// Split train and test set
let (trainSet, testSet) = dataTable.randomSplit(by: 0.8)
print(trainSet)
print(testSet)

// Fit SL Regressor with training set
let regressor = try MLLinearRegressor(trainingData: trainSet, targetColumn: "Profit")
print(regressor.trainingMetrics)

// Predictions
let predTrain = try regressor.predictions(from: trainSet)
