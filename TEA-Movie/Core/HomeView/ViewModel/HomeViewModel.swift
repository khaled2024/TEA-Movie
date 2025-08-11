//
//  HomeViewModel.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import Foundation

enum Status{
    case notStarted
    case loading
    case success
    case failure(Error)
}

@MainActor
@Observable
class HomeViewModel: ObservableObject {
    
    private(set) var status: Status = .notStarted
    private(set) var videoStatus: Status = .notStarted
    
    let networkingService = NetworkingService.shared
    var trendingMovies: [ShowModel] = []
    var trendingTVs: [ShowModel] = []
    var topRatedMovies: [ShowModel] = []
    var topRatedTVs: [ShowModel] = []
    var randomMovie: ShowModel? = nil
    
    var videoID: String?
    private let cacheFileName = Constants.HomeCashedFileName
    var refreshing = false
    
    
    func fetchVideoID(for title: String) async {
        videoStatus = .loading
        
        do {
            videoID = try await networkingService.fetchVideoID(for: title)
            videoStatus = .success
        } catch  {
            print("Error fetching video ID: \(error.localizedDescription)")
            videoStatus = .failure(error)
        }
    }
    
    // MARK: - fetching data
    func fetchAllData() async {
        status = .loading
        
        // cashed if there is no internet
        if !NetworkingService.isConnectedToInternet {
            if loadFromCache() {
                status = .success
                return
            } else {
                status = .failure(NSError(domain: "No internet and no cache available", code: -1))
                return
            }
        }
        
        if trendingMovies.isEmpty || refreshing == true {
            /// هنا لو عاوزين كل ريكوست يتنفذ لوحده حتي لو في واحد فشل الباقيين بيتنفذوا عادي
            
            async let trendingMoviesTask = Task { try? await networkingService.fetchShows(media: "movie", type: "trending") }
            async let trendingTVsTask = Task { try? await networkingService.fetchShows(media: "tv", type: "trending") }
            async let topRatedMoviesTask = Task { try? await networkingService.fetchShows(media: "movie", type: "top_rated") }
            async let topRatedTVsTask = Task { try? await networkingService.fetchShows(media: "tv", type: "top_rated") }
            
            
            let movies = await trendingMoviesTask.value
            let tvs = await trendingTVsTask.value
            let topMovies = await topRatedMoviesTask.value
            let topTVs = await topRatedTVsTask.value
            
            self.trendingMovies = movies ?? []
            self.trendingTVs = tvs ?? []
            self.topRatedMovies = topMovies ?? []
            self.topRatedTVs = topTVs ?? []
            
            if !trendingMovies.isEmpty{
                if let randomMovie = trendingMovies.randomElement() {
                    self.randomMovie = randomMovie
                }
            }else{
                if let anotherRandomMovie = topRatedMovies.randomElement() {
                    self.randomMovie = anotherRandomMovie
                }
            }
            
            if trendingMovies.isEmpty && trendingTVs.isEmpty && topRatedMovies.isEmpty && topRatedTVs.isEmpty {
                status = .failure(NSError(domain: "All requests failed..! \n Please try again later", code: 1, userInfo: nil))
            }else{
                // save the cache
                saveToCache()
                status = .success
            }
        }
        else{
            status = .success
        }
    }
    // for testing purposes
    func fetchAllRequestsWithEachOther() async {
        status = .loading
        if trendingMovies.isEmpty{
            do {
                /// هنا كل الريكوستات بتتنفذه مع بعضهم لو اول واحد فشل باقي الريكوستات بعد كده هتفشل بردو مش هتكمل
                
                async let trendingMovies = networkingService.fetchShows(media: "movie", type: "trending")
                async let trendingTVs = networkingService.fetchShows(media: "tv",type: "trending")
                async let topRatedMovies = networkingService.fetchShows(media: "movie", type: "top_rated")
                async let topRatedTVs = networkingService.fetchShows(media: "tv",type: "top_rated")
                
                self.trendingMovies = try await trendingMovies
                self.trendingTVs = try await trendingTVs
                self.topRatedMovies = try await topRatedMovies
                self.topRatedTVs = try await topRatedTVs
                
                status = .success
                
                
            } catch  {
                print(error.localizedDescription)
                status = .failure(error)
            }
        }else{
            status = .success
        }
    }
}


// MARK: - cashed home
extension HomeViewModel{
    
    
    private func cacheFileURL() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(cacheFileName)
    }
    
    private func saveToCache() {
        let cacheData = HomeCacheModel(
            trendingMovies: trendingMovies,
            trendingTVs: trendingTVs,
            topRatedMovies: topRatedMovies,
            topRatedTVs: topRatedTVs,
            randomMovie: randomMovie
        )
        do {
            let data = try JSONEncoder().encode(cacheData)
            try data.write(to: cacheFileURL(), options: .atomic)
            print("Cache saved ✅")
        } catch {
            print("Failed to save cache ❌", error)
        }
    }
    
    private func loadFromCache() -> Bool {
        let url = cacheFileURL()
        guard FileManager.default.fileExists(atPath: url.path) else { return false }
        do {
            let data = try Data(contentsOf: url)
            let cacheData = try JSONDecoder().decode(HomeCacheModel.self, from: data)
            trendingMovies = cacheData.trendingMovies
            trendingTVs = cacheData.trendingTVs
            topRatedMovies = cacheData.topRatedMovies
            topRatedTVs = cacheData.topRatedTVs
            randomMovie = cacheData.randomMovie
            print("Loaded data from cache")
            return true
        } catch {
            print(" Failed to load cache ❌", error)
            return false
        }
    }
    
}
