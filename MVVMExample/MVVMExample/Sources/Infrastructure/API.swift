//
//  API.swift
//  MVVMExample
//
//  Created by Gustavo Luís Soré on 29/10/19.
//  Copyright © 2019 Sore. All rights reserved.
//

import Foundation
import Reachability

typealias APICompletion = (APIResult<Data>) -> Void

class API {
    
    // MARK: - Public Methods
    
    static func get(urlString: String, completion: @escaping APICompletion) {
        
        if !hasConnectivity() {
            completion(.failure(error: .noInternet))
            return
        }
        
        guard let url: URL = URL(string: urlString) else {
            completion(.failure(error: .invalidURL))
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error: .requestError(error)))
            } else if let data = data {
                completion(.success(result: data))
            } else {
                completion(.failure(error: .noData))
            }
        }.resume()
    }
    
    // MARK: - Private Methods
    
    class func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != NetworkStatus.NotReachable.rawValue
    }
}

enum APIResult<T>
{
    case success(result: T)
    case failure(error: APIError)
}

enum APIError: Error {
    case invalidURL
    case noData
    case requestError(Error)
    case noInternet
}
