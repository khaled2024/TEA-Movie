//
//  Constants.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


class Constants{
    // api keys
    static let API_KEY = "4e64d9425b76606aee7f62bfe7fbc67b"
    static let YOUTUBE_API_KEY = "AIzaSyArNXn-meUwb9pG_zTWFx0Rhlr7JAORaUQ"
    
    // other urls
    static let BASE_URL = "https://api.themoviedb.org/"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500/"
    static let YOUTUBE_EMBED_URL = "https:youtube.com/embed"
    static let YOUTUBE_API_URL = "https://www.googleapis.com/youtube/v3/search"
    static let HomeCashedFileName = "home_cache.json"
    
    
    // for show movie url.
    //  https://api.themoviedb.org/3/trending/tv/day?api_key=4e64d9425b76606aee7f62bfe7fbc67b
    //  https://api.themoviedb.org/3/trending/movie/day?api_key=4e64d9425b76606aee7f62bfe7fbc67b
    // for youTube.
    //  https://www.googleapis.com/youtube/v3/search?q=sonic%20trailer&key=AIzaSyArNXn-meUwb9pG_zTWFx0Rhlr7JAORaUQ
    //for search
    //    https://api.themoviedb.org/3/search/movie
    
    // strings
    static let homeTab = "Home"
    static let upcomingTab = "Upcoming"
    static let searchTab = "Search"
    static let downloadTab = "Download"
    static let playBtnString = "Play"
    static let trendingMoviesTitle = "Trending Movies"
    static let trendingTVTitle = "Trending TV Shows"
    static let topratedMoviesTitle = "Top Rated Movies"
    static let topratedTVTitle = "Top Rated TV Shows"
    
    // image
    static let homeTabImage = "house"
    static let upcomingTabImage = "play.circle"
    static let searchTabImage = "magnifyingglass"
    static let downloadTabImage = "arrow.down.to.line"
    static let playBtnImage = "play.fill"
    static let info = "info.circle"

    
    // nav titles
    static let homeNavTitle = "Home"
    static let upcomingNavTitle = "Upcoming"
    static let searchNavTitle = "Search"
    static let downloadNavTitle = "Downloads"
    
    static let moreInfo = "More Info"
    
    static let testImageURL = "https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg"
    static let testImageURL2 = "https://images.unsplash.com/photo-1511875762315-c773eb98eec0?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bW92aWUlMjBwb3N0ZXJzfGVufDB8fDB8fHww"
    static let testImageURL3 = "https://images.unsplash.com/photo-1626808642875-0aa545482dfb?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZnJlZSUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D"
    
    static let showDetailsModel = ShowModel(adult: false, backdropPath: "8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", id: 100, overview: "Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello Hello ", posterPath: "8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", name: "Hello", title: "Hello", originalName: "Hello", mediaType: "tv", originalLanguage: "En", genreIDS: [10,20], popularity: 90.09, firstAirDate: "ksks", releaseDate: "", voteAverage: 10.0, voteCount: 12, originCountry: ["" , ""])
    
}
