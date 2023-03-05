import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-2
/// Single Serial Queue with Multiple Asynchronous Dispatch & Synchronous codes.


print("👩‍💻👨‍💻Print no:1👩‍💻👨‍💻")
DispatchQueue.main.async {
    print("---- First loop start -----")
    for i in 1...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

print("👩‍💻👨‍💻Print no:2👩‍💻👨‍💻")

DispatchQueue.main.async {
    print("---- Second loop start -----")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}

print("👩‍💻👨‍💻Print no:3👩‍💻👨‍💻")

DispatchQueue.main.async {
    print("---- Third loop start -----")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}

print("👩‍💻👨‍💻Print no:4👩‍💻👨‍💻")
