//
//  UITableView+Extensions.swift
//  MarvelApp
//
//  Created by Asmaa Elkhouly on 6/18/19.
//  Copyright © 2019 Asmaa Elkhouly. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    
    
    func registerNib<Cell : UITableViewCell>(cell : Cell.Type){
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeueCell <Cell : UITableViewCell>() ->Cell{
         let indetifireName = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: indetifireName) as? Cell else{
            fatalError("can't dequeue cell")
        }
        return cell
    }
    
}
