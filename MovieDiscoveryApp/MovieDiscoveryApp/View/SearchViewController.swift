//
//  SearchViewController.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import UIKit
import Combine

class SearchViewController: UIViewController {

    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var cancellables = Set<AnyCancellable>()
    
    let movieViewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()

    }
    

    private func bindViewModel() {
        movieViewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.tblMovies.reloadData()
                print("reponse received")
            }
            .store(in: &cancellables)
    }

}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = self.movieViewModel.movies[indexPath.row] // Get the user object from the view model
        self.configureCell(movie: movie, cell: cell)
        return cell
    }
    
    func configureCell(movie:MovieResult, cell: MovieCell) {
        cell.lblReleaseDate.text = movie.releaseDate.toYear()
        cell.lblTitle.text = movie.title
        cell.imgMoviePoster.setImage(from: WebPath.POSTER_BASE_URL + movie.posterPath, placeholder: UIImage(systemName: "person.circle"))
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIView.transition(with: tableView,duration:0.27,options:.transitionCrossDissolve,animations: { () -> Void in
            if let detailVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                detailVC.movie = self.movieViewModel.movies[indexPath.row]
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        
        }, completion: nil)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText.count >= 3 {
            movieViewModel.fetchMovies(searchQuery: searchText)
        } else if searchText.isEmpty {
            movieViewModel.fetchMovies()  // Reset to full user list
        }
    }
}
