//
//  MoviesService.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 01.08.24.
//

import Foundation


class MoviesService: MoviesServiceProtocol {
    
    private var urlSession: URLSession!
    private var url: String!
    
    required init(urlSession: URLSession = .shared, url: String) {
        self.urlSession = urlSession
        self.url = url
    }
    
    
    func fetchMovies(completionHandler: @escaping ([Movie]?, OnError?) -> Void) {
        guard let url = URL(string:  url) else {
            //TODO: do unit test when url is invalid
            completionHandler(nil, OnError.InvalidURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
            //TODO: do unit test when there is an error
            guard let data = data else {
                if let error = error {
                    completionHandler(nil, OnError.FailedRequest(description: error.localizedDescription))
                }
                return
            }
                do {
                    let movies = try JSONDecoder().decode([Movie].self, from: data)
                        completionHandler(movies, nil)
                    } catch {
                        completionHandler(nil, OnError.InvalidResponse)
                        return
                    }
                
           
        }
        dataTask.resume()
    }
}
