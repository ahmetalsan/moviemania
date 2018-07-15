//
//  ApiClient.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 14.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import Alamofire
import RxSwift

class APIClient {
    static func searchMovie(title:String, page:Int) -> Observable<[Movie]> {
        return Observable<[Movie]>.create { observer in
            
            Alamofire.request(APIRouter.searchMovie(title: title, page: page))
                .responseJSONDecodable { (response: DataResponse<Root>) in
                
                    switch response.result {
                    case .success(let root):
                        observer.onNext(root.results)
                    case .failure(let error):
                        observer.onError(error)
                    }
            }

            return Disposables.create()
        }
    }
}
