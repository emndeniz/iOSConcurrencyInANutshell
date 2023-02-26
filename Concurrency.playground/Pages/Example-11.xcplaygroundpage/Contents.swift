
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-10
/// Concurrent queue with multiple async block.

var value: Int = 20
let concurrentQueue = DispatchQueue(label: "com.example.serial",
                                attributes: .concurrent)
let someImageURL = "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg"

func downloadImages() {
 
    for i in 1...5 {
        concurrentQueue.async {
            print("\(i) starting to download")
            let imageURL = URL(string: someImageURL)!
            let _ = try! Data(contentsOf: imageURL)
            print("\(i) download complete")
        }
    }
}

downloadImages()


concurrentQueue.async {
    for i in 0...5 {
        value = i
        print("👨‍💻 \(value) 👩‍💻")
    }
}


print("Last Line 🎉")
