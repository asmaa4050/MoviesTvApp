//
//  NetworkClient.swift
//  ToDoList2019
//
//  Created by Osama on 6/22/19.
//  Copyright © 2019 Osama Gamal. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkClient {
    
    typealias onSuccess<T> = ((T) -> ())
    typealias onFailure = ( (_ error: Error) -> ())
    
    
    static func fetchMovies(endpoint :String ,onSuccess: @escaping onSuccess<MoviesResponse>,
                            onFailure: @escaping onFailure){
        performRequest( router: APIRouter.getMovies(endpoint :endpoint), success: { (model) in
            onSuccess(model)
        }) { (error) in
            onFailure(error)
        }
    }
    static func fetchMovieDetails(movieId :Int ,onSuccess: @escaping onSuccess<Movie>,
                            onFailure: @escaping onFailure){
        performRequest( router: APIRouter.getMovieDetails(movieId :movieId), success: { (model) in
            onSuccess(model)
        }) { (error) in
            onFailure(error)
        }
    }
    
    static func searchMovies(query : String, onSuccess: @escaping onSuccess<MoviesResponse>,
                            onFailure: @escaping onFailure){
        performRequest( router: APIRouter.searchMovies(query: query), success: { (model) in
            onSuccess(model)
        }) { (error) in
            onFailure(error)
        }
    }
    
    static func addMovieToWatchList(movieId : Int ,onSuccess: @escaping onSuccess<ResponseSuccessModel>,
                        onFailure: @escaping onFailure){
    performRequest( router: APIRouter.addToFav(movieId: movieId), success: { (model) in
        onSuccess(model)
    }) { (error) in
        onFailure(error)
    }
        
    }
    
   
    
    static func performRequest<T>(router: APIRouter, success: @escaping onSuccess<T>, failure: @escaping onFailure) where T: Decodable{
            AF.request(router).responseJSON { (response) in
                do {
                    print(response)
                    let responseModel = try JSONDecoder().decode(T.self, from: response.data!)
                    success(responseModel)
                } catch let error{
                    failure(error)
                }
        }
    }
}
