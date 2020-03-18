//
//  Utils.swift
//  flicker
//
//  Created by Asmaa Elkhouly on 6/11/19.
//  Copyright © 2019 Asmaa Elkhouly. All rights reserved.
//

import Foundation
import CryptoSwift
struct Utils{
  
       static let apikey = "f2f385b7a11b8c2bae357fd4f7fbd58b"
       static let privatekey = "c3e1975bd00dba16a17dc09c36a6e45a566b637c"
       static let URL = "http://gateway.marvel.com/v1/public/"
       static let ts = Date().timeIntervalSince1970.description
       static let hash = "\(ts)\(privatekey)\(apikey)".md5()
    
    enum ContentType: String {
        case json = "application/x-www-form-urlencoded; charset=utf-8"
        case accept = "*/*"
        case acceptEncoding = "gzip;q=1.0, compress;q=0.5"
    }

}
