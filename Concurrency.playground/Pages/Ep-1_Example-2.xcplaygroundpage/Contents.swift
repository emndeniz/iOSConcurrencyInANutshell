import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-2
/// Single Serial Queue with Multiple Asynchronous Dispatch & Synchronous codes.


print("π©βπ»π¨βπ»Print no:1π©βπ»π¨βπ»")
DispatchQueue.main.async {
    print("---- First loop start -----")
    for i in 1...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

print("π©βπ»π¨βπ»Print no:2π©βπ»π¨βπ»")

DispatchQueue.main.async {
    print("---- Second loop start -----")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}

print("π©βπ»π¨βπ»Print no:3π©βπ»π¨βπ»")

DispatchQueue.main.async {
    print("---- Third loop start -----")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}

print("π©βπ»π¨βπ»Print no:4π©βπ»π¨βπ»")
