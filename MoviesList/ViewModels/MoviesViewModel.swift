//
//  MoviesViewModel.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 05.08.24.
//

import Foundation

class Observable<T> {
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}



class MovieViewModelCell  {
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
}


class MoviesViewModel: MoviesViewModelProtocol {
    
    
    
    var moviesService: MoviesServiceProtocol
    var moviesCells:  Observable<[MovieViewModelCell]>?
    var error: Observable<OnError>?
    
    required init(moviesService: MoviesServiceProtocol, moviesCells: Observable<[MovieViewModelCell]>) {
        self.moviesService = moviesService
        self.moviesCells = moviesCells
    }
    
    
    func fetchMovies() {
        self.moviesService.fetchMovies { [weak self] (movies, error) in
            guard let error = error else {
                if let movies = movies {
                    for movie in movies {
                        self?.moviesCells?.value.append(MovieViewModelCell(name: movie.title))
                    }
                }
                return
            }
            self?.error = Observable(error)
        }
    }
    
    func getNumberMovies() -> Int {
        return moviesCells?.value.count ?? 0
    }
}
