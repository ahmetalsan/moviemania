//
//  HomeVC.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 14.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: BaseVC {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let searchResults = searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Movie]> in
                if query.isEmpty {
                    return .just([])
                }
                return APIClient.searchMovie(title: query, page: 1)
                    .catchErrorJustReturn([])
            }
            .observeOn(MainScheduler.instance)
        
        searchResults
            .bind(to: tableView.rx.items(cellIdentifier: "MovieCell")) {
                (index, repository: Movie, cell: MovieCell) in
                cell.nameLabel.text = repository.title;
            }
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

