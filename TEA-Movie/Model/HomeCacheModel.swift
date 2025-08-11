//
//  HomeCacheModel.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


struct HomeCacheModel: Codable {
    let trendingMovies: [ShowModel]
    let trendingTVs: [ShowModel]
    let topRatedMovies: [ShowModel]
    let topRatedTVs: [ShowModel]
    let randomMovie: ShowModel?
}
