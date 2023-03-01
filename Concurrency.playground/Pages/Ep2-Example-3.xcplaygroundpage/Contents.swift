
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// Example-9
/// Serial queue multiple async execution

var value: Int = 20
let serialQueue = DispatchQueue(label: "com.example.serial")
let someImageURL = "https://images.pexels.com/photos/842711/pexels-photo-842711.jpeg"

func downloadImages() {
 
    for i in 1...5 {
        serialQueue.async {
            let imageURL = URL(string: someImageURL)!
            let _ = try! Data(contentsOf: imageURL)
            print("\(i) download complete")
        }
    }
}

downloadImages()


serialQueue.async {
    for i in 0...5 {
        value = i
        print("👨‍💻 \(value) 👩‍💻")
    }
}


print("Last Line 🎉")
