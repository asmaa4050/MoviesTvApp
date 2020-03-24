//
//  EndPointEnum.swift
//  MoviesTvApp
//
//  Created by Asmaa on 28/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import Foundation


public enum Endpoint: String, CustomStringConvertible, CaseIterable {
case nowPlaying = "now_playing"
case upcoming
case popular
case topRated = "top_rated"

public var description: String {
    switch self {
    case .nowPlaying: return "Now Playing"
    case .upcoming: return "Upcoming"
    case .popular: return "Popular"
    case .topRated: return "Top Rated"
         
    }
}
   
    
   
}
