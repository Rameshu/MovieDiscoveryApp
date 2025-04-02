//
//  MovieDetailsViewController.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var txtOverview: UITextView!
    var movie: MovieResult? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblTitle.text = movie?.title
        lblReleaseDate.text = movie?.releaseDate
        txtOverview.text = movie?.overview
        imgPoster.setImage(from: WebPath.POSTER_BASE_URL + (movie?.posterPath ?? ""), placeholder: UIImage(systemName: "person.circle"))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
