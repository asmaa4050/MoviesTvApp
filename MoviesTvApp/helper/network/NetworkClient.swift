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
    
    
    static func fetchCharachters(limit : Int , offset : Int ,onSuccess: @escaping onSuccess<ResponseModel>,
                            onFailure: @escaping onFailure){
        performRequest( router: APIRouter.getCharachters(limit: limit, offset: offset), success: { (model) in
            onSuccess(model)
        }) { (error) in
            onFailure(error)
        }
    }
    
    static func searchCharachter (searchText : String , onSuccess: @escaping onSuccess<ResponseModel> , onFailure: @escaping onFailure ){
        
        performRequest( router: APIRouter.getCharachtersByName(searchText : searchText), success: { (model) in
            onSuccess(model)
        }) { (error) in
            onFailure(error)
        }
    }
    static func fetchCharacterDetails (charId : Int , detailsType : String, onSuccess: @escaping onSuccess<ResponseModel> , onFailure: @escaping onFailure){
        performRequest(router: APIRouter.getCharachterDetails(id: charId ,detailsType : detailsType), success: { (model) in
            onSuccess(model)
        }) { (error) in
            onFailure(error)
        }
    }
    
    static func performRequest<T>(router: APIRouter, success: @escaping onSuccess<T>, failure: @escaping onFailure) where T: Decodable{
            Alamofire.request(router).responseJSON { (response) in
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
