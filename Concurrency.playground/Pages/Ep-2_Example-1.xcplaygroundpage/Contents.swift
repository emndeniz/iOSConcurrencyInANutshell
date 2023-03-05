
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-7
/// Global Queues with QoS values

DispatchQueue.global(qos: .background).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- First loop start ----- qos: \(qos)")
    for i in 0...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}


DispatchQueue.global(qos: .utility).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- Second loop start ----- qos: \(qos)")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}



DispatchQueue.global(qos: .userInitiated).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- Third loop start ----- qos: \(qos)")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}



DispatchQueue.global(qos: .userInteractive).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    
    print("---- Fourth loop start ----- qos: \(qos)")
    for i in 16...20 {
        print("Value is \(i)")
    }
    print("---- Fourth loop end -----")
}



