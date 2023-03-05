import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/// Ep-3 Example-3
/// DispatchGroup with wait and timeout
///

// 1. Sample URLs
let urlNoDelay = "https://run.mocky.io/v3/bf4523b3-1f46-4fa2-a376-5374aadea7e6"
let urlTwoSecDelay = "\(urlNoDelay)?mocky-delay=2s"
let urlFiveSecDelay = "\(urlNoDelay)?mocky-delay=5s"

let loadDataDispatchGroup = DispatchGroup()

// 2. View controller for the playground
class MyViewController : UIViewController {
    // 3. Some label to show progress.
    let label = UILabel()
    override func loadView() {
        // 4. Simple UI setup.
        let view = UIView()
        view.backgroundColor = .white
        label.frame = CGRect(x: 20, y: 200, width: 300, height: 20)
        label.text = "Starting to fetch...⏱"
        label.textColor = .black
        view.addSubview(label)
        self.view = view
        
        // 6. Fetching all the required app data asynchronously on a global concurrent queue.
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.fetchAppData()
        }
        
    }
    
    private func fetchAppData() {
        // 7. Starting to execute all the requests one by one.
        self.fastRequest()
        self.midSpeedRequest()
        self.slowRequest()
        

        print("Waiting the current dispatch queue ✋")
        // 8. Waiting the current dispatch queue with timeout value
        let waitResult = loadDataDispatchGroup.wait(timeout: .now() + .seconds(3))
       
        // 9. Wait result block inform us either all executions are completed or timeout ocurred.
        switch waitResult {
        case .success:
            // 10. All requests are completed in timeout period.
            print("All of the requests are executed in given time 🤙")
            DispatchQueue.main.async {
                self.label.text = "All requests are completed 🎉"
            }
        case .timedOut:
            // 11. Not all the requests are finished so far.
            print("Exection completed with time out ⚠️")
            DispatchQueue.main.async {
                self.label.text = "Fetch partially completed 🎉"
            }
            
        }
        
    }
    
    private func fastRequest() {
        // 12. Increment the counter by enter function
        loadDataDispatchGroup.enter()
        print("Fast request started")
        Network.shared.execute(urlString: urlNoDelay) { result in
            // 13. Decrement the counter by leave function
            loadDataDispatchGroup.leave()
            switch result {
            case .success(_):
                print("Fast request success ✅")
            case .failure(_):
                print("Fast request fail ❌")
            }
        }
    }
    
    private func midSpeedRequest() {
        loadDataDispatchGroup.enter()
        print("Mid speed request started")
        Network.shared.execute(urlString: urlTwoSecDelay) { result in
            loadDataDispatchGroup.leave()
            switch result {
            case .success(_):
                print("Mid speed request success ✅")
            case .failure(_):
                print("Mid request failed ❌")
            }
        }
    }
    
    private func slowRequest() {
        loadDataDispatchGroup.enter()
        print("Slow request started")
        Network.shared.execute(urlString: urlFiveSecDelay) { result in
            loadDataDispatchGroup.leave()
            switch result {
            case .success(_):
                print("Slow request success ✅")
                
            case .failure(_):
                print("Slow request failed ❌")
            }
        }
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
