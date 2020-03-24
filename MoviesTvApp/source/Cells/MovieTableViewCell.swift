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
            print( cellMovie!.posterURL)
               MovieImage.kf.setImage(with:  cellMovie!.posterURL)
           }
       }

    
    func setupCell(){
       MovieImage.contentMode = .scaleAspectFill
         MovieName.textColor = UIColor.black
         MovieName.font = UIFont.systemFont(ofSize: 15)
        

     }
    /* func configureCell(url :String ,  title :String){
         
         MovieName.text = title
         guard let url = URL(string: url) else {
             return
         }
         
         MovieImage.kf.setImage(with: url)
     }*/
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
