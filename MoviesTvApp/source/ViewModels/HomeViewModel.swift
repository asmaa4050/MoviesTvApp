//
//  HomeViewModel.swift
//  MoviesTvApp
//
//  Created by Asmaa on 25/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


   
class HomeViewModel {
    
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let moviesList : PublishSubject<[Movie]> = PublishSubject()
    public let moviesCatergroisList : PublishSubject<[String]> = PublishSubject()
    public let homeError : PublishSubject<HomeError> = PublishSubject()
    public let loading :PublishSubject<Bool> = PublishSubject()
    public let showLoading = BehaviorRelay<Bool>(value: true)
    fileprivate var moviesResponseModel :MoviesResponse?
   


    
    func fetchMoviesData(endpoint : String){
        showLoading.accept(true)
        NetworkClient.fetchMovies(endpoint : endpoint ,onSuccess: { (model) in
                              print("success")
                                self.moviesResponseModel = model
                  if let list = self.moviesResponseModel?.results{
                    self.moviesList.onNext(list)
                    self.showLoading.accept(false)
                                  }
                               
                       }) { [unowned self]  error in
                           print(error)
                        self.showLoading.accept(false)
                       }
       
     }
    
    func fetchMoviesCategoris(){
        var categroisArr = [String]()
        Endpoint.allCases.forEach {
            categroisArr.append($0.description)
        }
        self.moviesCatergroisList.onNext(categroisArr)
    }
}
