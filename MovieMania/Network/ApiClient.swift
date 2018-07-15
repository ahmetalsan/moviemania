//
//  ApiClient.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 14.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import Alamofire

class APIClient {
    static func searchMovie(title:String, page:Int, completion:@escaping (Result<[Movie]>)->Void) {
        Alamofire.request(APIRouter.searchMovie(title: title, page: page))
            .responseJSONDecodable { (response: DataResponse<Root>) in
                switch response.result {
                case .success(let root):
                    let result = Result<[Movie]>.success(root.results)
                    completion(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
