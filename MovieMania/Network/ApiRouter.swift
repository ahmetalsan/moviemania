//
//  ApiRouter.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 14.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    //http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=batman&page=1
    case searchMovie(title: String, page: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .searchMovie:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        var params:Dictionary = [String:Any]()
        params[K.APIParameterKey.apiKey] = K.ProductionServer.key
        
        switch self {
        case .searchMovie(let title, let page):
            params[K.APIParameterKey.query] = title
            params[K.APIParameterKey.page] = page
        }
        
        return params
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }

}
