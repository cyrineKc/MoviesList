//
//  MoviesServiceProtocol.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 05.08.24.
//

import Foundation

 protocol MoviesServiceProtocol {
    init(urlSession: URLSession, url: String)
     func fetchMovies(completionHandler: @escaping ([Movie]?, OnError?) -> Void)
}
