import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/// Ep-4 Example-2
/// Semaphores
///

// 1. Sample URL to demonstrate API call.
private let someRandomAPI = "https://run.mocky.io/v3/bf4523b3-1f46-4fa2-a376-5374aadea7e6?mocky-delay=2s"

class MyViewController : UIViewController {
    
    let purchaseQueue = DispatchQueue(label: "com.example.buyQueue",
                                 attributes: .concurrent)
    // 1. Sempahore with initial value (counter) 1
    let semaphore = DispatchSemaphore(value: 1)
    
    let products: [Product] = [
        Product(name: "Movie Ticket", price: 30),
        Product(name: "Concert Ticket", price: 35)
    ]
    
    let purchaseHistoryLabel = UILabel()
    let walletLabel = UILabel()
    
    var walletBalance = 50
    
    override func loadView() {
        self.view = createRootUIView()
    }
    
    @objc func buyButtonTapped(_ sender: UIButton) {
        purchaseQueue.async {
            self.startPurchase(product:self.products[sender.tag])
        }
        
    }
    
    
    @objc func allButtonClicked() {
        for product in products {
            purchaseQueue.async(flags: .barrier) { [weak self] in
                self?.startPurchase(product: product)
            }
        }
    }
    
    func startPurchase(product: Product) {
        print("Purchasing product: \(product), walletBalance: \(walletBalance)")
        
        // 2. Critical section begins, wait semaphore
        semaphore.wait()

        guard walletBalance >= product.price else {
            print("Not enough balance to purchase \(product)")
            DispatchQueue.main.async { [weak self] in
                self?.purchaseHistoryLabel.text = (self?.purchaseHistoryLabel.text ?? "")
                + "\nNot enough balance to buy \(product.name) ⚠️"
            }
            return
        }
        
        print("Starting purchase ⌛️")
        // 3. Start actual API request
        Network.shared.execute(urlString: someRandomAPI) { [weak self] result in
            
            guard let self = self else {return}

            switch result {
            case .success(_):
                print("Purchase success")
                DispatchQueue.main.async {
                    self.walletBalance -= product.price
                    // 4. Crtical section ends, signal semaphore
                    self.semaphore.signal()
                    self.walletLabel.text = "Wallet Amount: $\(self.walletBalance)"
                    self.purchaseHistoryLabel.text = (self.purchaseHistoryLabel.text ?? "") + "\n\(product.name) purchased ✅"

                }
            case .failure(_):
                print("Fast request fail ❌")
                self.purchaseHistoryLabel.text = (self.purchaseHistoryLabel.text ?? "") + "\n\(product.name) purchase fail ❌"
                // 5. Crtical section ends, signal semaphore
                self.semaphore.signal()
            }
        }
    }
}

extension MyViewController {
    
    private func createRootUIView() -> UIView{
        let view = UIView()
        view.backgroundColor = .white
        
        walletLabel.frame = CGRect(x: 20, y: 100, width: 300, height: 20)
        walletLabel.text = "Wallet Balance: $\(walletBalance)"
        walletLabel.font = .boldSystemFont(ofSize: 18)
        walletLabel.textColor = .black
        
        view.addSubview(walletLabel)
        
        for index in 0..<products.count {
            let product = products[index]
            let labelYPoint = 130 + index * 20
            let label = UILabel(frame: CGRect(x: 20, y: labelYPoint, width: 300, height: 20))
            label.text = "\(product.name) $\(product.price)"
            label.textColor = .black
            view.addSubview(label)
            
            let buttonYPoint = 200 + index * 50
            let button = UIButton(frame: CGRect(x: 20, y: buttonYPoint, width: 200, height: 40))
            button.backgroundColor = .gray
            button.tag = index
            button.setTitle(product.name, for: .normal)
            button.addTarget(self, action:#selector(buyButtonTapped(_ :)), for: .touchUpInside)
            view.addSubview(button)
        }
        
        let buyAll = UIButton(frame: CGRect(x: 20, y: 400, width: 200, height: 40))
        buyAll.backgroundColor = .gray
        buyAll.setTitle("Buy All Tickets", for: .normal)
        buyAll.addTarget(self, action:#selector(allButtonClicked), for: .touchUpInside)
        
        view.addSubview(buyAll)
        
        purchaseHistoryLabel.frame = CGRect(x: 20, y: 450, width: 400, height: 200)
        purchaseHistoryLabel.text = ""
        purchaseHistoryLabel.numberOfLines = 0
        purchaseHistoryLabel.font = .boldSystemFont(ofSize: 14)
        purchaseHistoryLabel.textColor = .black
        view.addSubview(purchaseHistoryLabel)
        
        return view
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


struct Product {
    let name: String
    let price: Int
}
