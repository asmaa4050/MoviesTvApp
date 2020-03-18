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
    
    case getCharachters(limit :Int , offset: Int)
    case getCharachterDetails(id: Int, detailsType : String)
    case getCharachtersByName (searchText : String)
    
    var method: HTTPMethod {
        switch self {
        case .getCharachters(_,_) , .getCharachterDetails(_) , .getCharachtersByName :
            return .get
       
        }
    }

    
 var path: String {
    switch self {
        case .getCharachters(_,_) , .getCharachtersByName:
            return "characters"
        case let .getCharachterDetails(id , detailsType) :
            return "characters/\(id)/\(detailsType)"
        }
        
    }
    
    var parameters: Parameters? {
        switch self {
        case .getCharachters(let limit , let offset):
            return ["apikey": Utils.apikey , "ts": Utils.ts , "hash" : Utils.hash ,"limit" : limit ,"offset": offset]
        case .getCharachterDetails(_):
            return ["apikey": Utils.apikey , "ts": Utils.ts , "hash" : Utils.hash]
        case .getCharachtersByName(let searchText):
            return ["apikey": Utils.apikey , "ts": Utils.ts , "hash" : Utils.hash , "nameStartsWith" : searchText]
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
