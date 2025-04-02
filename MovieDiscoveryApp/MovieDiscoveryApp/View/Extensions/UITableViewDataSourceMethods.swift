//
//  UITableViewDataSourceMethods.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

//import Foundation
import UIKit

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
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
extension ViewController: UITableViewDelegate {
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

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let searchVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
}
