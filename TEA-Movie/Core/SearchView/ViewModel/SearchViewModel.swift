//
//  SearchViewModel.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import Foundation
import SwiftUI

@Observable
@MainActor
class SearchViewModel: ObservableObject{
    
    enum SearchStatus{
        case notStarted
        case loading
        case success
        case fetchingMovies
        case fetchingSeries
        case failure(Error)
    }
    
    private(set) var searchStatus: SearchStatus = .notStarted
    private let networkingService = NetworkingService.shared
    
    var searchResults: [ShowModel] = []
    var moviesResults: [ShowModel] = []
    var seriesResults: [ShowModel] = []
    var searchString: String = ""
    var isSearching: Bool = false
    var searchPlaceholder: String = "Search for movies..!"
    var switchToSeries: Bool = false

    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    /// Searches for shows based on the provided query and type.
    func search(for query: String , type: String) async {
        searchStatus = .loading
        do {
            searchResults = try await networkingService.search(type: type, query: query)
            searchStatus = .success
        } catch  {
            print("Error searching for \(query): \(error.localizedDescription)")
            searchStatus = .failure(error)
        }
        
    }
    
    /// Fetches trending movies.
    func fetchingMovies() async{
        do {
            moviesResults = try await networkingService.fetchShows(media: "movie", type: "trending")
            searchStatus = .fetchingMovies
        } catch {
            print("Error fetching movies: \(error.localizedDescription)")
        }
    }
    
    /// Fetches trending series.
    func fetchingSeries() async{
        do {
            seriesResults = try await networkingService.fetchShows(media: "tv", type: "trending")
            searchStatus = .fetchingSeries

        } catch {
            print("Error fetching series: \(error.localizedDescription)")
        }
    }
}

