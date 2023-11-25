import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


/// Example-4
/// Single Concurrent Queue with Multiple Asynchronous and Synchronous Dispatch.

let concurrentQueue = DispatchQueue(label: "aConcurrentQueue",
                                    attributes: .concurrent)

concurrentQueue.async {
    for i in 1...5 {
        print("First loop, Value is \(i)")
    }
}

concurrentQueue.sync {
    for i in 6...10 {
        print("Second Loop, Value is \(i)")
    }
}
// -----

concurrentQueue.async {
    for i in 11...15 {
        print("Third loop, Value is \(i)")
    }
}

concurrentQueue.async {
    for i in 16...20 {
        print("Fourth loop, Value is \(i)")
    }
}
