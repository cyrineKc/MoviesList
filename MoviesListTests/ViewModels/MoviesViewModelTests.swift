//
//  MoviesViewModel.swift
//  MoviesListTests
//
//  Created by Cyrine Kchir on 05.08.24.
//

import XCTest
@testable import MoviesList

final class MoviesViewModelTests: XCTestCase {
    
    var mockMoviesService: MockMoviesService!
    var moviesVM: MoviesViewModel!
    var moviesViewModel: Observable<[MovieViewModelCell]>!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockUrlSession = URLSession(configuration: config)
        mockMoviesService = MockMoviesService(urlSession: mockUrlSession, url: Constants.moviesURL)
        let moviesViewModel = Observable<[MovieViewModelCell]>([MovieViewModelCell]())
        moviesVM = MoviesViewModel(moviesService: mockMoviesService, moviesCells: moviesViewModel)
    }
    
    override func tearDownWithError() throws {
         mockMoviesService = nil
         moviesVM = nil
    }
    
    
    func test_MoviesViewModel_fetchMovies_CallMovieFetchService() {
        moviesVM.fetchMovies()
        XCTAssertTrue(mockMoviesService.isFetchMoviesMethodCalled, "fetchMovies() in class MoviesService")
        XCTAssertEqual(moviesVM.moviesCells?.value.count, 2, "Number of movies fetch should be 2 but is another number" )
        XCTAssertEqual(moviesVM.moviesCells?.value[0].name, "Titanic")
    }
    
    func testMoviesViewModel_WhenFetchMoviesWithError_ReturnError() {
        mockMoviesService.shouldReturnError = true
        moviesVM.fetchMovies()
        XCTAssertEqual(moviesVM.moviesCells?.value.count, 0, "movies cell should be 0 when there is an error returned from MoviesService but is not null")
        XCTAssertEqual(moviesVM.error?.value.localizedDescription, "failed request")
    }
    
    
    

   

}

