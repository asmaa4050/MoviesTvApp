//
//  moviesCategroisCollecionViewCell.swift
//  MoviesTvApp
//
//  Created by Asmaa on 28/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import UIKit

class moviesCategroisCollecionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentview: UIView!
    @IBOutlet weak var catergoryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(rgb: 0xD8D8D8).cgColor
        
       
    }
    public var endpoint :String! {
        didSet {
            catergoryName.text = endpoint
            
    
        }
    }
  

}
