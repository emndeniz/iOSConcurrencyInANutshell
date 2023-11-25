import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-1
/// Single Serial Queue with Multiple Asynchronous Dispatch.

//
let serialQueue = DispatchQueue(label: "aSerialQueue")



print("Hey")


serialQueue.async{
    print("wait...")

    for i in 0...50_000_000 {
        // Simulate time consuming job
    }

    print("GDG")
}

print("İstanbul")
