//
//  MockMoviesService.swift
//  MoviesListTests
//
//  Created by Cyrine Kchir on 05.08.24.
//

import Foundation
@testable import MoviesList

class MockMoviesService: MoviesServiceProtocol {
    
    var urlSession: URLSession!
    var url: String!
    var isFetchMoviesMethodCalled: Bool = false
    var shouldReturnError: Bool = false
    
    required init(urlSession: URLSession, url: String) {
        self.urlSession = urlSession
        self.url = url
    }
    
    func fetchMovies(completionHandler: @escaping ([Movie]?, OnError?) -> Void) {
        isFetchMoviesMethodCalled = true
        if shouldReturnError  {
            let error = OnError.FailedRequest(description: "failed request")
            completionHandler(nil, error)
        } else {
        let movies = [Movie(title: "Titanic", year: "1990"), Movie(title: "Test", year: "2000")]
            completionHandler(movies, nil)
        }
    }
    
    
    
}
