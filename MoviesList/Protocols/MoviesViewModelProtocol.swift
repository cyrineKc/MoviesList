//
//  MoviesViewModelProtocol.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 08.08.24.
//

import Foundation

protocol MoviesViewModelProtocol {
    
    var moviesCells:  Observable<[MovieViewModelCell]>? { get set }
    var moviesService: MoviesServiceProtocol { get set }
    var error: Observable<OnError>? { get set }
    
    init(moviesService: MoviesServiceProtocol, moviesCells: Observable<[MovieViewModelCell]>)
    
    func fetchMovies()
    func getNumberMovies() -> Int
    
}
