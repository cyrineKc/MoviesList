//
//  MockMoviesViewModel.swift
//  MoviesListTests
//
//  Created by Cyrine Kchir on 08.08.24.
//

import Foundation
@testable import MoviesList

class MockMoviesViewModel: MoviesViewModelProtocol {
    
    
    
    
    var moviesService: MoviesServiceProtocol
    var error: Observable<OnError>?
    var moviesCells: Observable<[MovieViewModelCell]>?
    var processFetchMoviesIsCalled: Bool = false
    
    
    required init(moviesService: MoviesServiceProtocol, moviesCells: Observable<[MovieViewModelCell]>) {
        self.moviesService = moviesService
        
        self.moviesCells = moviesCells
    }
    
    func fetchMovies() {
        processFetchMoviesIsCalled = true
        moviesCells?.value.append(MovieViewModelCell(name: "TEST"))
        moviesCells?.value.append(MovieViewModelCell(name: "Titanic"))
        
    }
    
    func getNumberMovies() -> Int {
        return moviesCells?.value.count ?? 0
    }
    
}
