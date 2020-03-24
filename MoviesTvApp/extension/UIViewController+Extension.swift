//
//  UIViewController+Extension.swift
//  MarvelApp
//
//  Created by Asmaa Elkhouly on 7/14/19.
//  Copyright © 2019 Asmaa Elkhouly. All rights reserved.
//

import Foundation
import  UIKit

extension UIViewController {
    
    func hideNavigationBar (){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
   
}
