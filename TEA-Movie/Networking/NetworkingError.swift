//
//  NetworkingError.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case invalidURL
    case invalidAPIKey
    case responseError
    case dataDecodingError(Error)
    case youtubeAPIError(String)
    
    
    case unknownError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .invalidAPIKey:
            return "The API Key provided is invalid."
        case .responseError:
            return "The server response was not valid. Please try again later."
        case .dataDecodingError(let error):
            return "Data decoding error: \(error.localizedDescription)"
        case .unknownError(let error):
            return "An unknown error occurred: \(error)"
        case .youtubeAPIError(let errorMessage):
            return "YouTube API error: \(errorMessage)"
        }
    }
}
