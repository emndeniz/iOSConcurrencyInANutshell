import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


/// Example-3
/// Single Concurrent Queue with Multiple Asynchronous Dispatch.

let concurrentQueue = DispatchQueue(label: "aConcurrentQueue",
                                    attributes: .concurrent)


concurrentQueue.async {
    for i in 1...5 {
        print("First loop, Value is \(i)")
    }
}

concurrentQueue.async {
    for i in 6...10 {
        print("Second loop, Value is \(i)")
    }
}


concurrentQueue.async {
    for i in 11...15 {
        print("Third loop, Value is \(i)")
    }
}

