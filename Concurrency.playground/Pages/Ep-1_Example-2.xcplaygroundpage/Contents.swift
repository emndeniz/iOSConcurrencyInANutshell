import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-2
/// Single Serial Queue with Multiple Asynchronous Dispatch & Synchronous codes.

let serialQueue = DispatchQueue(label: "aSerialQueue")

print("👩‍💻👨‍💻First Block👩‍💻👨‍💻")

serialQueue.async {
    for i in 1...5 {
        print("First loop, Value is \(i)")
    }
}

print("👩‍💻👨‍💻Second Block👩‍💻👨‍💻")

serialQueue.async {
    for i in 6...10 {
        print("Second loop, Value is \(i)")
    }
}

print("👩‍💻👨‍💻 End of line👩‍💻👨‍💻")
