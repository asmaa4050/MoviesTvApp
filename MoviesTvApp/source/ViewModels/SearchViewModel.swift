//
//  SearchViewModel.swift
//  MoviesTvApp
//
//  Created by Asmaa on 26/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
class SearchViewModel{
    public enum HomeError {
        case internetError(String)
        case serverMessage(String)
    }
    
    public let searchMoviesList : PublishSubject<[Movie]> = PublishSubject()
    public let homeError : PublishSubject<HomeError> = PublishSubject()
    fileprivate var moviesResponseModel :MoviesResponse?
    let showLoadingHud: Bindable = Bindable(false)
    
    
    func fetchMoviesSearchResult(query :String){
        showLoadingHud.value = true
        NetworkClient.searchMovies(query : query ,onSuccess: { (model) in
            print("success")
            self.moviesResponseModel = model
            if let list = self.moviesResponseModel?.results{
                self.searchMoviesList.onNext(list)
            }
            self.showLoadingHud.value = false
            
        }) { [unowned self]  error in
            print(error)
            self.showLoadingHud.value = false
        }
    }
    
    
}
