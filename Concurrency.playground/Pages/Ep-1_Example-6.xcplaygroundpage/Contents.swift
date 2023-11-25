import Foundation
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true

let serialQueue = DispatchQueue(label: "aSerialQueue")
let concurrentQueue = DispatchQueue(label: "aConcurrentQueue",
                                    attributes: .concurrent)

serialQueue.async {
    for i in 0...5 {
        print("First loop, Value is \(i)")
    }
}

serialQueue.sync {
    print("---- Second loop start -----")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}

serialQueue.async {
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

concurrentQueue.sync {
    print("---- Fifth loop start -----")
    for i in 21...25 {
        print("Value is \(i)")
    }
    print("---- Fifth loop end -----")
}


concurrentQueue.async {
    print("---- Sixth loop start -----")
    for i in 26...30 {
        print("Value is \(i)")
    }
    print("---- Sixth loop end -----")
}

