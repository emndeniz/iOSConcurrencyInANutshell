import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-1
/// Single Serial Queue with Multiple Asynchronous Dispatch.

// 
let serialQueue = DispatchQueue(label: "aSerialQueue")

serialQueue.async {
    print("---- First loop start -----")
    for i in 1...5 {
        print("First loop, Value is \(i)")
    }
}

serialQueue.sync {
    print("---- Second loop start -----")
    for i in 6...10 {
        print("Second loop, Value is \(i)")
    }
}

serialQueue.async {
    print("---- Third loop start -----")
    for i in 11...15 {
        print("Third loop, Value is \(i)")
    }
}
