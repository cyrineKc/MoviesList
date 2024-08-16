//
//  MoviesListTests.swift
//  MoviesListTests
//
//  Created by Cyrine Kchir on 01.08.24.
//

import XCTest
@testable import MoviesList

final class MoviesListServiceTests: XCTestCase {
    
    var sut: MoviesService!
    var mockURLProtocol : MockURLProtocol!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        sut = MoviesService(urlSession: urlSession, url: Constants.moviesURL)
    }

    override func tearDownWithError() throws {
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
       sut = nil
    }

    func testMoviesService_fetchMovies_returnSuccess() {
        let jsonString = "[{\"Title\":\"Avatar\", \"Year\":\"2009\", \"Title\":\"Avatar\"}]"
        let expectation = expectation(description: "Movies fetch Web Service Response Expectation ")
        MockURLProtocol.stubResponseData =  jsonString.data(using: .utf8)
        sut.fetchMovies { movies, error in
            XCTAssertEqual(movies?.count, 1, "movies fetch from api should be 1 but is not")
            XCTAssertEqual(movies?.first?.title, "Avatar", "first movie in the list should be avatar but it is not not")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    func testMoviesService_invalidURL_ShouldReturnError() {
        let sut = MoviesService( url: "")
        let expectation = self.expectation(description: "fetchMovies() method expectation for an invalid url returns an error")
        sut.fetchMovies { (movies, error) in
            XCTAssertEqual(error, OnError.InvalidURL,  "The fetchMovies()  did not return an expected error for an invalidRequestURLString error")
            XCTAssertNil(movies, "The fetchMovies should not return movies List when there is an invalid url")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testMoviesService_whenReturnedErrorAsResponse_ShouldReturnFalse() {
        let errorDescription = "unavailable json reponse from api"
        MockURLProtocol.error = OnError.FailedRequest(description: errorDescription)
        let expectation = self.expectation(description: "fetchMovies() method expectation for an error reponse returns an error")
        sut.fetchMovies { (movies, error) in
            XCTAssertNil(movies, "The fetchMovies() should not return Movies because there is an error as in response")
            XCTAssertEqual(error, OnError.FailedRequest(description: errorDescription), "The fetchMovies() should return parsingError but returned another response")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    
    
    

}
