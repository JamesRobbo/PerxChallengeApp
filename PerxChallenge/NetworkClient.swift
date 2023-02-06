//
//  NetworkClient.swift
//  PerxChallenge
//
//  Created by James Robinson on 06/02/2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case networkError(Error)
    case error(String)
}

class NetworkClient {
    
    static let shared = NetworkClient()
    
    // private init to force use of shared
    private init() {}
    
    /// - Parameters:
    /// - Model: model of object in response
    /// - Path: path of api call
    /// - Queries: Query parameters for api call
    private func performApiCall<T: Codable>(model: T.Type,
                                            path: String? = nil,
                                            queries: [URLQueryItem]? = nil,
                                            completion: @escaping (Result<T, NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.API.host
        
        if let path = path {
            components.path = path
        }
        
        var queryItems = [URLQueryItem]()
        if let queries = queries {
            queryItems.append(contentsOf: queries)
        }
        components.queryItems = queryItems
        
        guard let URL = components.url else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: URL) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let errorMessage = self.errorMessage(from: response) {
                completion(.failure(.error(errorMessage)))
                return
            }
            
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(model, from: data)
                    completion(.success(decoded))
                } catch let error {
                    print(error)
                }
            }
        }.resume()
    }
    
    private func errorMessage(from: URLResponse?) -> String? {
        guard let httpResponse = from as? HTTPURLResponse else {
            return nil
        }
        
        switch httpResponse.statusCode {
        case 429:
            return "Rate limit reached - rerun app"
        default:
            return nil
        }
    }
    
    // Pagination implemented using limit and skip.
    func fetchSearchMedication(search: String? = nil,
                               skip: Int? = nil,
                               completion: @escaping (Result<SearchResponse, NetworkError>) -> Void) {
        let limit = 100 + (skip ?? 0)
        var queries = [URLQueryItem(name: "limit", value: String(limit))]
        if let search = search,
           !search.isEmpty {
            queries.append(URLQueryItem(name: "search", value: "generic_name:\(search)"))
        }
        if let skip = skip {
            queries.append(URLQueryItem(name: "skip", value: String(skip)))
        }
        self.performApiCall(model: SearchResponse.self,
                            path: Constants.API.search,
                            queries: queries,
                            completion: completion)
    }
}
