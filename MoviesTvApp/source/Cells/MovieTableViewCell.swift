//
//  MovieTableViewCell.swift
//  MoviesTvApp
//
//  Created by Asmaa on 24/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var MovieImage: UIImageView!
    
    @IBOutlet weak var MovieName: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var addToWatchListBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            setupCell()
    
    }
    private let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           formatter.timeStyle = .none
           
           return formatter
       }()
    
     public var cellMovie : Movie! {
           didSet {
           self.MovieImage.clipsToBounds = true
            
               self.MovieName.text = cellMovie.title
            if cellMovie.ratingText.isEmpty {
                ratingLabel.text =  ""
                } else {
                    ratingLabel.text = cellMovie.ratingText

                }
           
               MovieImage.kf.setImage(with:  cellMovie!.posterURL)
           }
       }

    
    func setupCell(){
         MovieImage.contentMode = .scaleAspectFill
         MovieName.textColor = UIColor.black
         MovieName.font = UIFont.systemFont(ofSize: 15)
        MovieName.numberOfLines = 0
        MovieName.lineBreakMode = NSLineBreakMode.byWordWrapping
        MovieName.sizeToFit()
        addToWatchListBtn.setTitle("", for: .normal)
        addToWatchListBtn.setBackgroundImage(UIImage(named: "icon_fav_gray"), for: .normal)
        

     }
    
    @IBAction func addMovieToWatchListAction(_ sender: Any) {
        NetworkClient.addMovieToWatchList(movieId: 11,onSuccess: { (model) in
            print("success")
            
        }) { [unowned self]  error in
            print(error)
            
        }
    }
    
}
