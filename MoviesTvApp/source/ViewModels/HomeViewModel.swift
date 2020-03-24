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
    fileprivate var moviesResponseModel :MoviesResponse?
    let showLoadingHud: Bindable = Bindable(false)
    
    
    func fetchMoviesData(endpoint : String){
        showLoadingHud.value = true
        NetworkClient.fetchMovies(endpoint : endpoint ,onSuccess: { (model) in
            print("success")
            self.moviesResponseModel = model
            if let list = self.moviesResponseModel?.results{
                self.moviesList.onNext(list)
                self.showLoadingHud.value = false
                
            }
            
        }) { [unowned self]  error in
            print(error)
            self.showLoadingHud.value = false
            
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

class Bindable<T> {
    typealias Listener = ((T) -> Void)
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        self.value = v
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
