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
    case getMovieDetails(movieId :Int)
    case addToFav(movieId: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getMovies , .searchMovies(_) , .getMovieDetails(_):
            return .get
       
        case .addToFav(_):
            return .post
        }
    }

    
 var path: String {
    switch self {
        case let .getMovies(endpoint):
            return "/movie/\(endpoint)"
         case .searchMovies:
            return "/search/movie"
    case let .getMovieDetails(movieId):
        return "/movie/\(movieId)"
        
    case .addToFav(_):
        return "/account/watchlist"
    }
        
    }
    
    var baseURL: URL{
        switch self {
        case  let .addToFav(movieId):
            return URL(string: "\(Utils.URL)/account/watchlist?api_key=\(Utils.apiKey)&session_id=\(Utils.session_id)")!
        case let .getMovies(endpoint):
            return URL(string:"\(Utils.URL)/movie/\(endpoint)")!
             case .searchMovies:
                return URL(string:"\(Utils.URL)/search/movie")!
        case let .getMovieDetails(movieId):
            return URL(string:"\(Utils.URL)/movie/\(movieId)")!
     
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getMovies:
            return ["api_key": Utils.apiKey]
        case .searchMovies(let query):
            return ["api_key": Utils.apiKey, "query": query]
        case .getMovieDetails(let movieId):
             return ["api_key": Utils.apiKey]
        case .addToFav(let movieId):
            return ["media_type": "movie", "media_id": movieId , "watchlist" : true]
            
        }
       
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL
            //try Utils.URL.asURL().appendingPathComponent(path)
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
