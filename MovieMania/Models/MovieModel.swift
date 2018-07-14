//
//  MovieModel.swift
//  MovieMania
//
//  Created by Ahmet Alsan on 14.07.2018.
//  Copyright © 2018 Veoss. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String
}

extension MovieModel {
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview
    }
}
