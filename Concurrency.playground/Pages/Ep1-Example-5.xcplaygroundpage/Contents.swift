import Foundation
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-5
/// A Serial Queue alongside a Concurrent Queue with  Multiple Asynchronous Dispatch.


// In defaults queues are serial.
let serialQueue = DispatchQueue(label: "aSerialQueue")
// In case we add the concurrent attribute they become concurrent.
let concurrentQueue = DispatchQueue(label: "aConcurrentQueue",
                                    attributes: .concurrent)

serialQueue.async {
    print("Serial-First")
}

serialQueue.async {
    print("Serial-Second")
}

serialQueue.async {
    print("Serial-Third")
}


concurrentQueue.async {
    print("Concurrent-Fourth")
}

concurrentQueue.async {
    print("Concurrent-Fifth")
}

concurrentQueue.async {
    print("Concurrent-Sixth")
}
