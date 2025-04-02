//
//  APIManager.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 01/04/25.
//


import Foundation
import Combine

class APIManager {
    static let shared = APIManager()  // Singleton instance
    private init() {}

    func fetchData<T: Decodable>(searchQuery: String? = nil, from url: String) -> AnyPublisher<T, Error> {
        var urlString = url

        if let query = searchQuery, !query.isEmpty {
            urlString += "&query=\(query)"
        }
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
