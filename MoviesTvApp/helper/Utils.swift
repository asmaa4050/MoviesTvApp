//
//  Utils.swift
//  flicker
//
//  Created by Asmaa Elkhouly on 6/11/19.
//  Copyright © 2019 Asmaa Elkhouly. All rights reserved.
//

import Foundation

struct Utils{
  
         static let URL = "https://api.themoviedb.org/3"
         static let apiKey = "13526a435cf73bafd0ac6a76104ca94c"
         static let session_id = "105298308fbdba6de676d8bfb68da846"
    static let wash = "?api_key=\(Utils.apiKey)&session_id=\(Utils.session_id)"
    
    enum ContentType: String {
        case json = "application/x-www-form-urlencoded; charset=utf-8"
        case accept = "*/*"
        case acceptEncoding = "gzip;q=1.0, compress;q=0.5"
    }

}
