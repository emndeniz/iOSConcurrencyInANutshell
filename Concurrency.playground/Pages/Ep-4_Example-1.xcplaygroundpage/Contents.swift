import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/// Ep-4 Example-1
/// Dispatch Barrier
///

// 1. A concurrent to execute buy operations
let purchaseQueue = DispatchQueue(label: "com.example.buyQueue",
                             attributes: .concurrent)

// 2. View controller for the playground
class MyViewController : UIViewController {
    
    // 3. Products sample array
    let products: [Product] = [
        Product(name: "Movie Ticket", price: 30),
        Product(name: "Concert Ticket", price: 35)
    ]
    
    // 4. Labels to show wallet and purchases.
    let walletLabel = UILabel()
    let purchaseHistoryLabel = UILabel()

    var walletBalance = 50
    
    override func loadView() {
        // 5. createRootUIView function will initate all required UI elements
        self.view = createRootUIView()
    }
    
    @objc func buyButtonTapped(_ sender: UIButton) {
        // 6. Buy button action. (For single item)
        purchaseQueue.async {
            self.startPurchase(product:self.products[sender.tag])
        }
    }
    
    
    @objc func allButtonClicked() {
        // 7. Buy all items button action
        for product in products {
            // 8. Purchase all items one by one.
            purchaseQueue.async(flags: .barrier) { [weak self] in
                self?.startPurchase(product: product)
            }
        }
    }
    
    func startPurchase(product: Product) {
        print("Purchasing product: \(product), walletBalance: \(walletBalance)")
        
        // 9. Prevent purchase if balance is not enough.
        guard walletBalance >= product.price else {
            print("Not enough balance to purchase \(product)")
            DispatchQueue.main.async { [weak self] in
                // 10. Update purchase history with warning.
                self?.purchaseHistoryLabel.text = (self?.purchaseHistoryLabel.text ?? "")
                + "\nNot enough balance to buy \(product.name) ⚠️"
            }
            return
        }
        
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // 11. Update balance and UI elements after purchase completed.
            self.walletBalance -= product.price
            self.walletLabel.text = "Wallet Balance: $\(self.walletBalance)"
            self.purchaseHistoryLabel.text = (self.purchaseHistoryLabel.text ?? "") + "\n\(product.name) purchased ✅"
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
