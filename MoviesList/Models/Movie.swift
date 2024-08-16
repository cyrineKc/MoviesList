//
//  Movie.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 01.08.24.
//

import Foundation

struct Movie: Decodable {
 
    let title: String
    let year: String
     
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
}
