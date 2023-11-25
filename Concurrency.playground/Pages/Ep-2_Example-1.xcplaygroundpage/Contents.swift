
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-7
/// Global Queues with QoS values

DispatchQueue.global(qos: .background).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified

    for i in 0...5 {
        print("1️⃣ First loop, QoS: \(qos), Value is \(i)")
    }
}


DispatchQueue.global(qos: .utility).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified

    for i in 6...10 {
        print("2️⃣ Second loop, QoS: \(qos), Value is \(i)")
    }
}



DispatchQueue.global(qos: .userInitiated).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified

    for i in 11...15 {
        print("3️⃣ Third loop, QoS: \(qos), Value is \(i)")
    }
}



DispatchQueue.global(qos: .userInteractive).async {
    let qos = DispatchQoS.QoSClass(rawValue: qos_class_self()) ?? .unspecified

    for i in 16...20 {
        print("4️⃣ Fourth loop, QoS: \(qos), Value is \(i)")
    }

}


