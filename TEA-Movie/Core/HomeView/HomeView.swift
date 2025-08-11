//
//  HomeView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

enum NavigationDestination: Hashable {
    case showDetails(ShowModel)
    case seeMore(title: String, shows: [ShowModel])
}

struct HomeView: View {
    @State var vm : HomeViewModel = HomeViewModel()
    @State private var showDetailsPath = NavigationPath()
    @EnvironmentObject var downloadShowModel: DownloadShowModel
    
    // MARK: - body
    var body: some View {
        NavigationStack(path: $showDetailsPath) {
            GeometryReader { geo in
                ScrollView{
                    switch vm.status {
                    case .notStarted:
                        Text("Loading...")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .loading:
                        LoadingView()
                            .frame(width: geo.size.width, height: geo.size.height)
                    case .success:
                        SuccessLazyVStack(width: geo.size.width, height: geo.size.height)
                        //  here if we path one destination
                        //                        .navigationDestination(for: ShowModel.self) { showDetails in
                        //                            ShowDetailsView(show: showDetails)
                        //                        }
                        //  here if we path more than one destination
                            .navigationDestination(for: NavigationDestination.self) { destination in
                                switch destination {
                                case .showDetails(let show):
                                    ShowDetailsView(show: show)
                                case .seeMore(let title, let shows):
                                    SeeMoreView(title: title, shows: shows)
                                }
                            }
                    case .failure(let error):
                        ErrorView(errorString: error.localizedDescription) {
                            Task{
                                await vm.fetchAllData()
                            }
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    }
                    
                }
            }
            .refreshable {
                vm.refreshing = true
                Task{
                    await vm.fetchAllData()
                }
                
            }
        }
        .task {
            await vm.fetchAllData()
        }
    }
    // MARK: - SuccessLazyVStack
    private func SuccessLazyVStack(width: CGFloat , height: CGFloat)-> some View{
        LazyVStack{
            CustomAsyncImage(url: URL(string: vm.randomMovie?.posterImageURL ?? ""), useCache: true, content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .overlay{
                        LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8),Gradient.Stop(color: .gradient, location: 1)],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
                
            } ,placeholder: {
                LoadingView()
                    .frame(width: width, height: height * 0.8)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
            })
            .frame(width: width, height: height * 0.8)
            .ignoresSafeArea()
            
            // buttons
            HStack {
                // play btn
                Button(Constants.playBtnString, systemImage: Constants.playBtnImage) {
                    // Action for play button
                    if let randomMovie = vm.randomMovie {
                        showDetailsPath.append(NavigationDestination.showDetails(randomMovie))
                    }
                    else {
                        
                    }
                }
                .primaryStyle(bgColor: Color.theme.greenColor)
                // download btn
                DownloadButton(show: vm.randomMovie)
            }
            .padding(.bottom, 20)
            ///trendingMovies
            HorizontalListView(headerTitle: Constants.trendingMoviesTitle,shows: vm.trendingMovies) { show in
                self.showDetailsPath.append(NavigationDestination.showDetails(show))
            }seeMoreAction: {
                showDetailsPath.append(NavigationDestination.seeMore(title: "Trending movies", shows: vm.trendingMovies))
            }
            /// trendingTVs
            HorizontalListView(headerTitle: Constants.trendingTVTitle,shows: vm.trendingTVs){ show in
                self.showDetailsPath.append(NavigationDestination.showDetails(show))
            }seeMoreAction: {
                showDetailsPath.append(NavigationDestination.seeMore(title: "Trending TVs", shows: vm.trendingTVs))
            }
            ///topRatedMovies
            HorizontalListView(headerTitle: Constants.topratedMoviesTitle,shows: vm.topRatedMovies){ show in
                self.showDetailsPath.append(NavigationDestination.showDetails(show))
            }seeMoreAction: {
                showDetailsPath.append(NavigationDestination.seeMore(title: "Top rated movies", shows: vm.topRatedMovies))
            }
            ///topRatedTVs
            HorizontalListView(headerTitle: Constants.topratedTVTitle,shows: vm.topRatedTVs){ show in
                self.showDetailsPath.append(NavigationDestination.showDetails(show))
            }seeMoreAction: {
                showDetailsPath.append(NavigationDestination.seeMore(title: "Top rated TV", shows: vm.topRatedTVs))
            }
        }
    }
    // MARK: -  DownloadButton
    @ViewBuilder func DownloadButton(show: ShowModel?) -> some View {
        // download button
        let downloadedShowModel = downloadShowModel.downloadedShows
        if downloadedShowModel.contains(where: { $0.id == show?.id }) {
            Button("Downloaded", systemImage: "checkmark.circle.fill") {
                if let show = show{
                    // Remove from downloads
                    downloadShowModel.removeShowFromDownloads(show)
                }
            }
            .primaryStyle(bgColor: Color.black, btnWidth: 150)
        }else{
            Button(Constants.downloadTab, systemImage: Constants.downloadTabImage) {
                if let randomMovie = vm.randomMovie{
                    downloadShowModel.addShowToDownloads(randomMovie)
                }
            }
            .primaryStyle(bgColor: Color.theme.redColor,btnWidth: 130)
        }
    }
}
