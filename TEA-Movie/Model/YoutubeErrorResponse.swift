//
//  YoutubeErrorResponse.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import Foundation

struct YouTubeErrorResponse: Decodable {
   
    let error: YouTubeError?
}

struct YouTubeError: Decodable {
    let code: Int?
    let message: String?
    let errors: [YouTubeInnerError]?
}

struct YouTubeInnerError: Decodable {
    let message: String?
    let domain: String?
    let reason: String?
}
