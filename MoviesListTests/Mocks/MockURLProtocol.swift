//
//  MockURLProtocol.swift
//  MoviesListTests
//
//  Created by Cyrine Kchir on 01.08.24.
//

import Foundation


class MockURLProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = MockURLProtocol.error {
            let stubNSError = NSError(domain: "StubNSError", code: -99, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
            self.client?.urlProtocol(self, didFailWithError: stubNSError)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
            self.client?.urlProtocolDidFinishLoading(self)
        }
        
    }
    
    override func stopLoading() { }
    
}
