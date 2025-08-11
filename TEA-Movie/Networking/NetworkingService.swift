//
//  NetworkingService.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import Foundation
import SwiftUI
import Network


class NetworkingService{
    static let shared = NetworkingService()
    private init() {}
    
    
    
    
    // MARK: - Search
    func search(type: String ,query: String) async throws -> [ShowModel] {
        let urlString = "\(Constants.BASE_URL)3/search/\(type)?api_key=\(Constants.API_KEY)&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            throw NetworkingError.invalidURL
        }
        print("Search URL: \(url)")
        let (data, respo) = try await URLSession.shared.data(from: url)
        guard let httpResponse = respo as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingError.responseError
        }
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(APIResponse.self, from: data)
            print("Search Results: \(decodedResponse.results?.count ?? 0) items found")
            return decodedResponse.results ?? []
        } catch  {
            print("Decoding Error in search: \(error)")
            throw NetworkingError.dataDecodingError(error)
        }
    }
    
    
    // MARK: - fetch Upcoming movies
    func fetchUpcomingMovies() async throws -> [ShowModel] {
        let urlString = "\(Constants.BASE_URL)3/movie/upcoming?api_key=\(Constants.API_KEY)"
        let fetchURL = URL(string: urlString)
        guard let fetchURL = fetchURL else {
            throw NetworkingError.invalidURL
        }
        print("Fetch URL: \(fetchURL)")
        let (data, respo) = try await URLSession.shared.data(from: fetchURL)
        // Check for HTTP response status code
        guard let httpResponse = respo as? HTTPURLResponse else {
            throw NetworkingError.responseError
        }
        if !(200...299).contains(httpResponse.statusCode) {
            if let errorMessage = try? JSONDecoder().decode(ResponseError.self, from: data) {
                let message = "status code : ( \(errorMessage.statusCode ?? 400) ) - \(errorMessage.statusMessage ?? "")"
                print(" \(message)")
                throw NetworkingError.unknownError(message)
            } else {
                throw NetworkingError.responseError
            }
        }
        do {
            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            return decodedResponse.results ?? []
        } catch  {
            print("Decoding Error in upcoming movies: \(error)")
            throw NetworkingError.dataDecodingError(error)
        }
    }
    
    // MARK: - fetchShows
    func fetchShows(media : String , type: String) async throws -> [ShowModel] {
        // first do catch for creating the URL
        // then do catch for fetching the data
        do {
            guard let fetchURL = try createFetchURL(media: media, type: type) else { return [] }
            print("Fetch URL: \(fetchURL)")
            
            let (data, respo) = try await URLSession.shared.data(from: fetchURL)
            guard let httpResponse = respo as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkingError.responseError
            }
            let decoder = JSONDecoder()
            do {
                let dataResponse =  try decoder.decode(APIResponse.self, from: data)
                return dataResponse.results ?? []
            } catch  {
                print("Decoding Error in fetching shows: \(error)")
                throw NetworkingError.dataDecodingError(error)
            }
        } catch  {
            print("Error creating fetch URL for media \(media) and type \(type): \(error)")
        }
        return []
        
    }
    // MARK: - fetchVideoID
    func fetchVideoID(for title: String) async throws -> String? {
        let urlString = "\(Constants.YOUTUBE_API_URL)?part=snippet&q=\(title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")%20trailer&key=\(Constants.YOUTUBE_API_KEY)"
        guard let url = URL(string: urlString)else{return nil}
        print("YouTube URL: \(url)")
        let (data, respo) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = respo as? HTTPURLResponse else {
            throw NetworkingError.responseError
        }
        // for youtube error url
        if !(200...299).contains(httpResponse.statusCode) {
            if let errorMessage = try? JSONDecoder().decode(YouTubeErrorResponse.self, from: data) {
                let message = errorMessage.error?.message
                print("YouTube API Error: \(message ?? "")")
                throw NetworkingError.youtubeAPIError(message ?? "Unknown error")
            } else {
                throw NetworkingError.responseError
            }
        }
        // for youtube success url
        do {
            let dataResponse =  try JSONDecoder().decode(YoutubeResponse.self, from: data)
            let videoID = dataResponse.items?.first?.id?.videoID ?? "No Video ID Found"
            print("Video ID: \(videoID)")
            return videoID
        } catch {
            print("Decoding Error for youtube id : \(error)")
            throw NetworkingError.dataDecodingError(error)
        }
    }
    enum FetchURLType: String{
        case trending = "trending"
        case topRated = "top_rated"
        case upcoming = "upcoming"
    }
    // MARK: - createFetchURL
    private func createFetchURL(media: String, type: String) throws -> URL? {
        if type == FetchURLType.trending.rawValue {
            guard let fetchURL = URL(string: Constants.BASE_URL)?
                .appending(path: "3/\(type)/\(media)/day")
                .appending(queryItems: [
                    URLQueryItem(name: "api_key", value: Constants.API_KEY),
                ])else{
                throw NetworkingError.invalidURL
            }
            return fetchURL
        }else if type == FetchURLType.topRated.rawValue || type == FetchURLType.upcoming.rawValue{
            // https://api.themoviedb.org/3/tv/top_rated?api_key=4e64d9425b76606aee7f62bfe7fbc67b
            guard let fetchURL = URL(string: Constants.BASE_URL)?
                .appending(path: "3/\(media)/\(type)")
                .appending(queryItems: [
                    URLQueryItem(name: "api_key", value: Constants.API_KEY),
                ])else{
                throw NetworkingError.invalidURL
            }
            return fetchURL
        }else{
            throw NetworkingError.invalidURL
        }
    }
}
// MARK: - NetworkingService
extension NetworkingService {
    static var isConnectedToInternet: Bool {
        let monitor = NWPathMonitor()
        var connected = false
        let semaphore = DispatchSemaphore(value: 0)
        
        monitor.pathUpdateHandler = { path in
            connected = path.status == .satisfied
            semaphore.signal()
            monitor.cancel()
        }
        monitor.start(queue: .global())
        _ = semaphore.wait(timeout: .now() + 2)
        return connected
    }
}
