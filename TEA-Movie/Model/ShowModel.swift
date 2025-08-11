//
//  ShowModel.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let page: Int
    let results: [ShowModel]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ShowModel: Codable,Identifiable,Hashable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let overview, posterPath: String?
    let name,title,originalName: String?
    let mediaType: String?
    let originalLanguage: String?
    let genreIDS: [Int]
    let popularity: Double?
    let firstAirDate , releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int
    let originCountry: [String]?
    
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name,title
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
        case releaseDate = "release_date"
    }
    
    // Computed property to build the image URL
    var posterImageURL: String {
        if let posterPath = posterPath, !posterPath.isEmpty {
            return "\(Constants.IMAGE_BASE_URL)\(posterPath)"
        }
        return ""
    }
}
