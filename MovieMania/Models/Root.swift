//
//  Root.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 15.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import Foundation

struct Root: Codable {
    let results: [Movie]
    
    enum CodingKeys: CodingKey {
        case results
    }
    
}
