import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Create Work item
let workItem = DispatchWorkItem {
    // Start a basic for loop
    for i in 0..<5 {
        if workItem.isCancelled {
            print("Task was cancelled")
            return
        }
        print(i)
        // Sleep thread for simulate some work
        sleep(1)
    }
}

// Start the work item in queue
let queue = DispatchQueue.global()
print("Starting the work item")
queue.async(execute: workItem)

// Cancel the work item.
print("Cancelling the work item")
workItem.cancel()
