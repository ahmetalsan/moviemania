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
import SDWebImage
import Foundation

class HomeVC: BaseVC {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    let searchText = Variable<String>("")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        let _ = searchBar.rx.searchButtonClicked.asObservable().subscribe(onNext: { [weak self] in
            if let weakSelf = self, let text = weakSelf.searchBar.text {
                weakSelf.searchText.value = text
            }
        })
        
        let searchResults = searchText.asObservable().flatMapLatest { query -> Observable<[Movie]> in
            if query.isEmpty {
                return .just([])
            }
            
            return APIClient.searchMovie(title: query).catchErrorJustReturn([])
        }
        .observeOn(MainScheduler.instance)
        
        searchResults
            .bind(to: tableView.rx.items(cellIdentifier: "MovieCell")) {
                (index, repository: Movie, cell: MovieCell) in
                cell.nameLabel.text = repository.title
                cell.overviewLabel.text = repository.overview
                cell.releaseDateLabel.text = repository.releaseDate
                
                let imagePath = K.ProductionServer.posterBaseURL + repository.posterPath
                let imageURL = URL(string: imagePath)
                cell.posterImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
            }
            .disposed(by: disposeBag)
    }
}

