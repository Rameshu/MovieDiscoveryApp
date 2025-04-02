//
//  MovieCell.swift
//  MovieDiscoveryApp
//
//  Created by RAMESHUZ on 02/04/25.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
