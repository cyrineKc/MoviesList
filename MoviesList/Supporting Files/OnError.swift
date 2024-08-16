//
//  OnError.swift
//  MoviesList
//
//  Created by Cyrine Kchir on 01.08.24.
//

import Foundation

 enum OnError: Error, Equatable {
    
    case InvalidURL
    case InvalidResponse
    case FailedRequest(description: String)
}

extension OnError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .InvalidURL, .InvalidResponse:
            return ""
        case .FailedRequest(description: let description):
            return NSLocalizedString(description, comment: "")
        }
    }
}
