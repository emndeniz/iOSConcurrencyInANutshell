import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


/// Example-4
/// Single Concurrent Queue with Multiple Asynchronous and Synchronous Dispatch.

let concurrentQueue = DispatchQueue(label: "aConcurrentQueue",
                                    attributes: .concurrent)

concurrentQueue.async {
    print("---- First loop start -----")
    for i in 1...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

concurrentQueue.sync {
    print("---- Second loop start -----")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}


concurrentQueue.async {
    print("---- Third loop start -----")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}

concurrentQueue.async {
    print("---- Fourth loop start -----")
    for i in 16...20 {
        print("Value is \(i)")
    }
    print("---- Fourth loop end -----")
}
