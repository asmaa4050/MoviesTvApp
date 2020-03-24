//
//  APIRouter.swift
//  ToDoList2019
//
//  Created by Osama on 6/22/19.
//  Copyright © 2019 Osama Gamal. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getMovies(endpoint : String)
    case searchMovies (query :String)
  
    
    var method: HTTPMethod {
        switch self {
        case .getMovies , .searchMovies(_) :
            return .get
       
        }
    }

    
 var path: String {
    switch self {
        case let .getMovies(endpoint):
            return "/movie/\(endpoint)"
         case .searchMovies:
            return "/search/movie"
        
        }
        
    }
    
    var parameters: Parameters? {
        switch self {
        case .getMovies:
            return ["api_key": Utils.apiKey]
        case .searchMovies(let query):
            return ["api_key": Utils.apiKey, "query": query]
        }
       
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Utils.URL.asURL().appendingPathComponent(path)
        print(">>>>>>>>>>\(url)")
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            return try URLEncoding.default.encode(request, with: parameters)
            
        }
        print(try URLEncoding.default.encode(request, with: parameters))
        
        return request
    }
    
    
}
