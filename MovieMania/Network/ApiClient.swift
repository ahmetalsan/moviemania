//
//  ApiClient.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 14.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import Alamofire

class APIClient {
    static func searchMovie(title:String, page:Int, completion:@escaping (Result<MovieModel>)->Void) {
        Alamofire.request(APIRouter.searchMovie(title: title, page: page))
            .responseJSONDecodable { (response: DataResponse<MovieModel>) in
                completion(response.result)
        }
    }
}
