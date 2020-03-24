//
//  MovieDetailsViewModel.swift
//  MoviesTvApp
//
//  Created by Asmaa on 29/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
class MovieDetailsViewModel {
    public let movieObj : PublishSubject<Movie> = PublishSubject()
    let showLoadingHud: Bindable = Bindable(false)
    
    func fetchMovieByID(movieId : Int){
        showLoadingHud.value = true
        NetworkClient.fetchMovieDetails(movieId : movieId ,onSuccess: { (model) in
            print("success")
            self.movieObj.onNext(model)
            self.showLoadingHud.value = false
        }) { [unowned self]  error in
            print(error)
            self.showLoadingHud.value = true
        }
    }
}
