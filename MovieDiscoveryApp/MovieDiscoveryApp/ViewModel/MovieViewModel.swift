//
//  MovieViewModel.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import Foundation
import Combine

class MovieViewModel:ObservableObject {
    @Published var movies: [MovieResult] = []  // Data source for the table view
    private var cancellables = Set<AnyCancellable>()

    func fetchMovies(searchQuery: String? = nil) {
        var endPoint = WebPath.movie.path
        
        if let query = searchQuery, !query.isEmpty {
            endPoint = WebPath.searchMovie.path
        }
        
        APIManager.shared.fetchData(searchQuery: searchQuery, from: endPoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching movies: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] (fetchedMovies: Movie) in
                self?.movies = fetchedMovies.results
            })
            .store(in: &cancellables)
    }
}
