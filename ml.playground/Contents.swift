import CreateML
import Foundation

// Importing the dataset
let fileURL = URL(fileURLWithPath: "/Users/hernan/Downloads/store.json")
var dataTable = try MLDataTable(contentsOf: fileURL)
print(dataTable)

// Remove unused
dataTable.removeColumn(named: "timestamp")
dataTable.removeColumn(named: "placemark")
dataTable = dataTable.dropMissing()
print(dataTable)

// Remove -1 values (missing)
extension MLDataTable {
    mutating func cleanupColumn(named name: String, removing target: Double) {
        let column = self[name] as MLDataColumn<Double>
        let updated = column.map { value -> Double? in
            return value == target ? nil : value
        }
        removeColumn(named: name)
        addColumn(updated, named: name)
    }
}
dataTable.cleanupColumn(named: "course", removing: -1)
dataTable.cleanupColumn(named: "speed", removing: -1)
print(dataTable)

// Split train and test set
let (trainSet, testSet) = dataTable.randomSplit(by: 0.8)
print(trainSet)
print(testSet)

// Fit Regressor

