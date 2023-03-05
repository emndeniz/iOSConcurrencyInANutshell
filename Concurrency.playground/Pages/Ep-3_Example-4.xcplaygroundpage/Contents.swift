import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

/// Ep-3 Example-4
/// DispatchGroup with wait and timeout
///

// 1. Sample URL that fecthes movie list
private let moviesListAPI = "https://run.mocky.io/v3/1249cf39-2dfa-4ee3-81aa-b4d9676b1f66"


// 2. View controller for the playground
class MyViewController : UIViewController {
    // 3. A Label and a text field for search box and result
    let searchResultLabel = UILabel()
    var searchTextField: UITextField!
    
    // 4. Creating a global work item to be able to cancel.
    var movieSearchWorkItem: DispatchWorkItem?
    
    override func loadView() {

        let view = UIView()
        view.backgroundColor = .white
        
        // 5. Label init to show result
        searchResultLabel.frame = CGRect(x: 20, y: 150, width: 300, height: 20)
        searchResultLabel.text = "Search result:"
        searchResultLabel.textColor = .black
        
        // 6. Text field init and styling
        searchTextField = UITextField(frame: CGRect(x: 20, y: 200, width: 300, height: 40))
        searchTextField.placeholder = "Type to search 🔎"
        searchTextField.borderStyle = UITextField.BorderStyle.roundedRect
        searchTextField.backgroundColor = .lightGray.withAlphaComponent(0.5)
        searchTextField.delegate = self
        
        view.addSubview(searchResultLabel)
        view.addSubview(searchTextField)
        self.view = view
        
    }
    
    // 7. This is the function we will call when user type something.
    func searchInMovies(textToSearch: String) {
        // 8. Cancel previously created work item if exist.
        movieSearchWorkItem?.cancel()
        
        // 9. Create a local work item
        let workItem = DispatchWorkItem {
            print("Starting to search for text: \(textToSearch)")
            // 10. Starting to fetch data from API
            Network.shared.execute(urlString: moviesListAPI) { result in
                switch result {
                case .success(let response):
                    
                    print("List fetched from API successfully, \(response)")
                    // 11. In case response successful search the text that user wants to search.
                    let result = JSONHelper().searchStringInJSONArray(jsonArray: response, searchText: textToSearch)
                    
                    DispatchQueue.main.async {
                        // 12. Depending on the search reult update the UI.
                        if let result = result{
                            self.searchResultLabel.text = "Search result: \(result)"
                           
                        }else {
                            self.searchResultLabel.text = "Search result: Not found 🤷‍♂️"
                        }
                    }
                    
                case .failure(_):
                    print("Failed to fetch API ❌")
                }
            }
        }
        
        // 13. Storing the newly created work item reference
        movieSearchWorkItem = workItem
        // 14. Starting the execute Work item with 1 sec delay.
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: (.now() + .seconds(1)),
                                                             execute: workItem)
    }
}

// 15. UITextFieldDelegate extension to detect user typing
extension MyViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == searchTextField {
            if let textToSearch = textField.text?.appending(string){
                // 16. Call searchInMovies function to start search operation.
                searchInMovies(textToSearch: textToSearch)
            }
        }
        return true
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
