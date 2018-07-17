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
        let baseURL = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        
        // Parameters
        switch self {
        case .searchMovie(_):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        /*if let parameters = parameters {
         do {
         urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
         } catch {
         throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
         }
         }*/

        return urlRequest
    }

}
