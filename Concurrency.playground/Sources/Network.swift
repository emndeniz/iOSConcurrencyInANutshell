import Foundation
import PlaygroundSupport


public class Network {
    public static let shared = Network()

    public init() {}
    
    public func execute(urlString: String,
                         completion: @escaping (Result<String,Error>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        //print("Network-Sending request \(urlRequest)")
        URLSession.shared.dataTask(with: urlRequest) { data, response , error in
            if let error = error{
                //print("Network-Error")
                completion(.failure(error))
            }else if let data = data {

                let str = String(decoding: data, as: UTF8.self)
                //print("Network-Data received, str: \(str)")
                completion(.success(str))
            }
        }.resume()
    }
}
