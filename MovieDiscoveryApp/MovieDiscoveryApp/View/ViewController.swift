//
//  ViewController.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var tblMovies: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var cancellables = Set<AnyCancellable>()
    
    let movieViewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
        movieViewModel.fetchMovies()
    }

    private func bindViewModel() {
        movieViewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.tblMovies.reloadData()
            }
            .store(in: &cancellables)
    }

}

