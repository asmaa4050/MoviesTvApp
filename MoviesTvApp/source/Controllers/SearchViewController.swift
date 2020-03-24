//
//  SearchViewController.swift
//  MoviesTvApp
//
//  Created by Asmaa on 26/07/1441 AH.
//  Copyright © 1441 Asmaa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController ,UISearchBarDelegate {
    
    @IBOutlet weak var searchResultTabelView: UITableView!
    var searchViewModel = SearchViewModel()
    fileprivate var searchMoviesList = PublishSubject<[Movie]>()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

           setupNavigationBar()
           setupBinding()
        
        
    }
    
    // MARK: navigationBar
       
       func setupNavigationBar(){
        
        let searchBar = UISearchBar(frame: CGRect.zero)
           searchBar.delegate = self
           searchBar.showsCancelButton = true
           searchBar.tintColor = UIColor.red
           self.navigationItem.titleView = searchBar
         navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: true);

       }
       
      
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           if let searchText = searchBar.text{
               if validateEmptyText(text: searchText){
                searchViewModel.fetchMoviesSearchResult(query: searchText)
               }
               else{
                   // H        showWarrningMessage()
               }
           }
           
       }
    
       
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           searchViewModel.fetchMoviesSearchResult(query: searchText)
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           self.navigationController?.popViewController(animated: true)
       }
       
       func validateEmptyText(text : String) -> Bool{
           if text != "" {
               return true
           }
           return false
       }
    
    // MARK: Binding
    
    func setupBinding(){
       searchViewModel.searchMoviesList
        .observeOn(MainScheduler.instance)
        .bind(to: self.searchMoviesList)
        .disposed(by: disposeBag)
        
        searchResultTabelView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
               
               searchMoviesList.bind(to: searchResultTabelView.rx.items(cellIdentifier: "MovieTableViewCell", cellType: MovieTableViewCell.self)) {  (row,movie,cell) in
                   cell.cellMovie = movie
                   }.disposed(by: disposeBag)
        
        searchResultTabelView.rowHeight = 80
        
    }

}
