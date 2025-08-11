//
//  UpcomingViewModel.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import Foundation

@MainActor
@Observable
class UpcomingViewModel: ObservableObject {
    var upcomingMovies: [ShowModel] = []
    private(set) var upcomingStatus: Status = .notStarted
    private let networkingService = NetworkingService.shared
    
    func fetchUpcomingMovies() async {
        upcomingStatus = .loading
        do {
            upcomingMovies =  try await networkingService.fetchShows(media: "movie", type: "upcoming")
            upcomingStatus = .success
            if upcomingMovies.isEmpty{
                upcomingMovies =  try await networkingService.fetchShows(media: "movie", type: "upcoming")
                upcomingStatus = .success
            }
            else{
                upcomingStatus = .success
            }
        } catch  {
            print("Error fetching upcoming movies: \(error.localizedDescription)")
            upcomingStatus = .failure(error)
        }
    }
}

