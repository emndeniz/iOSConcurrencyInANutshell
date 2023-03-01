import Foundation
import PlaygroundSupport


public class Network {
    public static let shared = Network()

    public init() {}
    
    public func execute(urlString: String,
                         completion: @escaping (Result<String,Error>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        URLSession.shared.dataTask(with: urlRequest) { data, response , error in
            if let error = error{
                print("Error")
                completion(.failure(error))
            }else if let data = data {
                print("Data received")
                let str = String(decoding: data, as: UTF8.self)
                completion(.success(str))
            }
        }.resume()
    }

}
