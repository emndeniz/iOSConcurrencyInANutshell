import Foundation
import PlaygroundSupport

public struct JSONHelper {
    
    public init() {
        
    }
    
    /// Sşimple function that searchs given string in simple json array.
    /// - Parameters:
    ///   - jsonArray: Json Array
    ///   - searchText: Search Text
    /// - Returns: First matched result if exist. If not returns nil.
    public func searchStringInJSONArray(jsonArray: String, searchText: String) -> String? {
        let data = jsonArray.data(using: .utf8)!

        do {
            let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [String]
            for element in jsonArray {
                if element.contains(searchText){
                    return element
                }
            }
            return nil
        } catch {
            print("Error parsing JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
}
