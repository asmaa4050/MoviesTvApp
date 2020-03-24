//
//  MovieDetailsViewController.swift
//  MoviesTvApp
//
//  Created by Asmaa on 24/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var mvoieName: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    @IBOutlet weak var movieType: UILabel!
    
    @IBOutlet weak var ratinglabel: UILabel!
    
    @IBOutlet weak var movieDuration: UILabel!
    
    @IBOutlet weak var tagelibeLabel: UILabel!
    
    @IBOutlet weak var geneableLabel: UILabel!
    @IBOutlet weak var castlabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var ratingStarsLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    var movieDetailsViewModel = MovieDetailsViewModel()
    var movieId : Int = 0
    let disposeBag = DisposeBag()
    fileprivate var movieObj = PublishSubject<Movie>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViews()
        fetchMovieDetails()
    
    }
    
    
    func bindViews(){
        //------------loading ------------
        movieDetailsViewModel.showLoadingHud.bind() { [weak self] visible in
                          if let `self` = self {
                              PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
                              visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
                          }
                      }
        //---------MovieObject
        movieDetailsViewModel.movieObj
                   .observeOn(MainScheduler.instance)
                   .bind(to: movieObj)
                   .disposed(by: disposeBag)
        movieObj.subscribe(onNext: { [weak self] item in
            guard let self = self else { return }
            self.movie = item
        }).disposed(by: disposeBag)
    }
    func setMovieId(movieId : Int){
        self.movieId = movieId
    }
    
    func fetchMovieDetails(){
           movieDetailsViewModel.fetchMovieByID(movieId: movieId)
    }
    
    
    
    public var movie : Movie! {
        didSet {
            self.mvoieName.text = movie.title
            self.movieReleaseDate.text = movie.release_date
            self.movieType.text = movie.type
            if movie.vote_count == 0 {
                           ratinglabel.isHidden = true
                       } else {
                           ratinglabel.isHidden = false
                           ratinglabel.text = movie.voteAveragePercentText
                       }
            self.tagelibeLabel.text = movie.tagline
            self.movieDuration.text = "\(movie.runtime ?? 0) mins"
            if let genres = movie.genres, genres.count > 0 {
                          geneableLabel.isHidden = false
                          geneableLabel.text = genres.map { $0.name }.joined(separator: ", ")
                      } else {
                          geneableLabel.isHidden = true
                      }
           if let casts = movie.credits?.cast, casts.count > 0 {
                          castlabel.isHidden = false
                          castlabel.text = "Cast: \(casts.prefix(upTo: 3).map { $0.name }.joined(separator: ", "))"
                      } else {
                          castlabel.isHidden = true
                      }
                      
                      if let director = movie.credits?.crew.first(where: {$0.job == "Director"}) {
                          directorLabel.isHidden = false
                          directorLabel.text = "Director: \(director.name)"
                      } else {
                          directorLabel.text = "lang : En"
                      }
            
            ratingStarsLabel.text = movie.ratingText
            overviewLabel.text = movie.overview
            movieImage.kf.setImage(with: movie.posterURL)
            
            
        }
    }
    
    func setupViews(){
        movieImage.contentMode = .scaleAspectFill
         overviewLabel.numberOfLines = 0
         overviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
         overviewLabel.sizeToFit()
        mvoieName.numberOfLines = 0
        mvoieName.lineBreakMode = NSLineBreakMode.byWordWrapping
        mvoieName.sizeToFit()
        tagelibeLabel.numberOfLines = 0
        tagelibeLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        tagelibeLabel.sizeToFit()
         geneableLabel.numberOfLines = 0
         geneableLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
         geneableLabel.sizeToFit()

    }


}
