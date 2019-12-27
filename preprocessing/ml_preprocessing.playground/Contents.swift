import CreateML
import Foundation

// Importing the dataset
let csvFile = Bundle.main.url(forResource: "Data", withExtension: "csv")!
var dataTable = try MLDataTable(contentsOf: csvFile)
print(dataTable)

// Taking care of missing data
let ageColumn = dataTable["Age"] as MLDataColumn<Int>
let ageMean = ageColumn.mean() ?? 0
let salaryColumn = dataTable["Salary"] as MLDataColumn<Int>
let salaryMean = salaryColumn.mean() ?? 0
dataTable = dataTable.fillMissing(columnNamed: "Salary", with: .double(salaryMean))
print(dataTable)

// Encoding categories (Feature, onehot)
// Is this needed with CoreML?

// Split train and test set
let (trainSet, testSet) = dataTable.randomSplit(by: 0.8)
print(trainSet)
print(testSet)

// Save
let csvTarget = csvFile.appendingPathExtension("2")
try dataTable.writeCSV(to: csvTarget)
print("done: " + csvTarget.relativePath)
