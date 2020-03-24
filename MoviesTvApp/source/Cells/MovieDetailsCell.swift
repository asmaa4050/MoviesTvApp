//
//  MovieDetailsCell.swift
//  MoviesTvApp
//
//  Created by Asmaa on 24/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import UIKit

class MovieDetailsCell: UITableViewCell {

    @IBOutlet weak var trailerImage: UIImageView!
    
    @IBOutlet weak var movieRateView: UIView!
    
    @IBOutlet weak var movieReleaseDate: UIView!
    
    @IBOutlet weak var movieRateLabel:
    UILabel!
    
    @IBOutlet weak var movieAdultLabel: UILabel!
    
    
    @IBOutlet weak var movieDurationLabel: UILabel!
    
    @IBOutlet weak var movieTaglineLabel: UILabel!
    
    @IBOutlet weak var movieGenableLabel: UILabel!
    
    @IBOutlet weak var movieCastLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
