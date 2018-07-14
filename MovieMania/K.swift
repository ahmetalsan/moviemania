//
//  Constants.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 14.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "http://api.themoviedb.org/3"
        static let key = "2696829a81b1b5827d515ff121700838"
    }
    
    struct APIParameterKey {
        static let query = "query"
        static let apiKey = "api_key"
        static let page = "page"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
