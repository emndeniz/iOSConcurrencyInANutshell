import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


let urlNoDelay = "https://run.mocky.io/v3/bf4523b3-1f46-4fa2-a376-5374aadea7e6"
let urlTwoSecDelay = "\(urlNoDelay)?mocky-delay=2s"
let urlFiveSecDelay = "\(urlNoDelay)?mocky-delay=5s"

let loadDataDispatchGroup = DispatchGroup()

class MyViewController : UIViewController {
    let label = UILabel()
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Starting to fetch...⏱"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.fetchAppData()
        }
        
    }
    
    private func fetchAppData() {
        self.fastRequest()
        self.midSpeedRequest()
        self.slowRequest()

        loadDataDispatchGroup.notify(queue: .main) { [weak self] in
            self?.label.text = "Fetch completed 🎉"
        }
    }
    
    private func fastRequest() {
        
        loadDataDispatchGroup.enter()
        Network.shared.execute(urlString: urlNoDelay) { result in
            loadDataDispatchGroup.leave()
            switch result {
            case .success(_):
                print("Fast request success")
            case .failure(_):
                print("Fast request fail")
            }
        }
    }
    
    private func midSpeedRequest() {
        loadDataDispatchGroup.enter()
        Network.shared.execute(urlString: urlTwoSecDelay) { result in
            loadDataDispatchGroup.leave()
            switch result {
            case .success(_):
                print("Mid request success")
            case .failure(_):
                print("Mid request failed")
            }
        }
    }
    
    private func slowRequest() {
        loadDataDispatchGroup.enter()
        Network.shared.execute(urlString: urlFiveSecDelay) { result in
            loadDataDispatchGroup.leave()
            switch result {
            case .success(_):
                print("Slow request success")
                
            case .failure(_):
                print("Slow request failed")
            }
        }
    }
    
    
}


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()









