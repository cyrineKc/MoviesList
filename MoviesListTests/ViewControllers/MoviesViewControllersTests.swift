//
//  MoviesViewControllersTests.swift
//  MoviesListTests
//
//  Created by Cyrine Kchir on 08.08.24.
//

import XCTest
@testable import MoviesList


final class MoviesViewControllersTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut:  MoviesViewController!
    var moviesMockVM: MockMoviesViewModel!
    //var mockMoviesTableView : MockTableView!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockUrlSession = URLSession(configuration: config)
        let mockMoviesService = MockMoviesService(urlSession: mockUrlSession, url: Constants.moviesURL)
        let moviesViewModelCells = Observable<[MovieViewModelCell]>([MovieViewModelCell]())
         moviesMockVM = MockMoviesViewModel(moviesService: mockMoviesService, moviesCells: moviesViewModelCells)
       
        sut = MoviesViewController(viewModel: moviesMockVM)
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        moviesMockVM = nil
        storyboard = nil
    }

    

    func testMoviesViewController_WhenViewLoaded_processFetchMoviesIsCalled() throws {
        //sut.fetchMovies()
        
        XCTAssertTrue(moviesMockVM.processFetchMoviesIsCalled, "fetchMovies() in MoviesMVVM should be called but is not")
        XCTAssertEqual(sut.tableView.numberOfSections, 1, "the number of section should be 1 after fetchMovies is called but it is \(sut.tableView.numberOfSections)")
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2, "the number of section rows should be 2 after fetchMovies is called but it is \(sut.tableView.numberOfRows(inSection: 0))")
    }
    
    
    
    
    
    


}
