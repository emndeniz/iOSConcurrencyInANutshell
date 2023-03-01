
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-8
/// Multiple queues with target queues.

// Serial Queue
let queueA = DispatchQueue(label: "QueueA",
                           qos: .utility)

// Concurrent Queue
let queueB = DispatchQueue(label: "QueueB",
                           qos: .background,
                           attributes: .concurrent,
                           target: queueA)


queueA.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- First loop start ----- qos: \(qos), queueName:\(name)")
    for i in 0...5 {
        print("Value is \(i)")
    }
    print("---- First loop end -----")
}

queueA.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Second loop start ----- qos: \(qos), queueName:\(name)")
    for i in 6...10 {
        print("Value is \(i)")
    }
    print("---- Second loop end -----")
}


queueB.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Third loop start ----- qos:\(qos), queueName:\(name)")
    for i in 11...15 {
        print("Value is \(i)")
    }
    print("---- Third loop end -----")
}


queueB.async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified
    let name =  String(cString:__dispatch_queue_get_label(nil))
    print("---- Fourth loop start ----- qos: \(qos), queueName:\(name)")
    for i in 16...20 {
        print("Value is \(i)")
    }
    print("---- Fourth loop end -----")
}
