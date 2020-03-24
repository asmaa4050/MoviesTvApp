//
//  ViewController.swift
//  MoviesTvApp
//
//  Created by Asmaa on 23/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class HomeViewController: UIViewController , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var moviesTabelView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var moviesCategroiesCollectionView: UICollectionView!
    
    fileprivate var moviesList = PublishSubject<[Movie]>()
    fileprivate var moviesCatergroisList = PublishSubject<[String]>()
    var homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    var defaultSelectedFlag : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBinding()
        setupTabelView()
        homeViewModel.fetchMoviesCategoris()
        homeViewModel.fetchMoviesData(endpoint: Endpoint.nowPlaying.rawValue)
        
    }
    // MARK: navigationBar
    func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.white
        setupDefaultNavigationItems()
        
    }
    
    func setupDefaultNavigationItems(){
        
        let SearchBarButton = UIBarButtonItem(image: UIImage(named: "icn-nav-search" ) , style: .done, target: self, action: #selector(showSearchViewController))
        self.navigationItem.rightBarButtonItem = SearchBarButton
        let logo = UIImage(named: "icn-nav-marvel.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    // MARK: searchBar
    @objc func showSearchViewController(){
        
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    // MARK: Binding
    func setupBinding(){
        //-----------------loading ------------
        homeViewModel.showLoading.asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: indicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        //-----------------home error  ------------
        homeViewModel.homeError
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    print(message)
                case .serverMessage(let message):
                    print(message)
                }
            })
            .disposed(by: disposeBag)
        
        bindMoviesTabelViewData()
        bindCategoriesCollectionViewData()
        
        
        
    }
    func bindMoviesTabelViewData(){
        
        //-----------------movie tabel  ------------
        homeViewModel.moviesList
            .observeOn(MainScheduler.instance)
            .bind(to: moviesList)
            .disposed(by: disposeBag)
        
        moviesTabelView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        
        moviesList.bind(to: moviesTabelView.rx.items(cellIdentifier: "MovieTableViewCell", cellType: MovieTableViewCell.self)) {  (row,movie,cell) in
            cell.cellMovie = movie
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        
        
        moviesTabelView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.showMovieDetialsViewController(movieId : item.id)
            }).disposed(by: disposeBag)
    }
    
    func bindCategoriesCollectionViewData(){
        
        //-----------------catergories collection view  ------------
        homeViewModel.moviesCatergroisList
            .observeOn(MainScheduler.instance)
            .bind(to: moviesCatergroisList)
            .disposed(by: disposeBag)
        
        moviesCategroiesCollectionView.register(UINib(nibName: "moviesCategroisCollecionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviesCategroisCollecionViewCell")
        
        moviesCatergroisList.bind(to: moviesCategroiesCollectionView.rx.items(cellIdentifier: "moviesCategroisCollecionViewCell", cellType: moviesCategroisCollecionViewCell.self)) {  (row,catName,cell) in
            cell.endpoint = catName
            if(row == 0){
                cell.contentView.backgroundColor = UIColor(rgb: 0xD8D8D8)
                self.defaultSelectedFlag = false
            }
            
            
        }.disposed(by: disposeBag)
        
        moviesCategroiesCollectionView
            .rx
            .itemSelected
            .subscribe(onNext:{ indexPath in
                self.getMoviesByCategoryName(catIndex: indexPath.row)
                let cell = self.moviesCategroiesCollectionView!.cellForItem(at: indexPath)
                cell?.contentView.backgroundColor = UIColor(rgb: 0xD8D8D8)
                self.deselectDefaultCategory()
            }).disposed(by: disposeBag)
        
        moviesCategroiesCollectionView.rx.itemDeselected
            .subscribe(onNext:{ indexPath in
                let cell = self.moviesCategroiesCollectionView!.cellForItem(at: indexPath)
                cell?.contentView.backgroundColor = UIColor(rgb: 0xffffff)
            }).disposed(by: disposeBag)
    }
    
    func deselectDefaultCategory(){
        if(!self.defaultSelectedFlag){
            let newIndexPath = IndexPath(row: 0, section: 0)
            let cell = self.moviesCategroiesCollectionView!.cellForItem(at: newIndexPath)
            cell?.contentView.backgroundColor = UIColor(rgb: 0xffffff)}
        self.defaultSelectedFlag = true
    }
    func setupTabelView(){
        moviesTabelView.rowHeight = 80
        moviesCategroiesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
    func showMovieDetialsViewController(movieId : Int){
        if let movieDetailsViewController = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
        }
    }
    func getMoviesByCategoryName(catIndex : Int){
        switch(catIndex){
        case 0 :
            self.homeViewModel.fetchMoviesData(endpoint: Endpoint.nowPlaying.rawValue)
        case 1 :
            self.homeViewModel.fetchMoviesData(endpoint: Endpoint.upcoming.rawValue)
        case 2 :
            
            self.homeViewModel.fetchMoviesData(endpoint: Endpoint.popular.rawValue)
        case 3 :
            self.homeViewModel.fetchMoviesData(endpoint: Endpoint.topRated.rawValue)
            
        default:
            self.homeViewModel.fetchMoviesData(endpoint: Endpoint.nowPlaying.rawValue)
        }
    }
    
     // MARK: collection view delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 3.5
        let hardCodedPadding:CGFloat = 10
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}




