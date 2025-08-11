//
//  MainTabView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var downloadShowModel: DownloadShowModel
    var body: some View {
        TabView{
            
            HomeView()
                .tabItem {
                    Label(Constants.homeTab, systemImage: Constants.homeTabImage)
                }
            
            UpcomingView()
                .tabItem {
                    Label(Constants.upcomingTab, systemImage: Constants.upcomingTabImage)
                }
            
            SearchView()
                .tabItem {
                    Label(Constants.searchTab, systemImage: Constants.searchTabImage)
                }
            
            DownloadView()
                .tabItem {
                    Label(Constants.downloadTab, systemImage: Constants.downloadTabImage)
                }
                .badge(downloadShowModel.downloadedShowsCount)
            
        }
        .tint(Color.red)
    }
}

#Preview {
    MainTabView()
}



// MARK: -  for ios 18 +
//
//Tab(Constants.homeTab, systemImage: Constants.homeTabImage) {
//    HomeView()
//}
//
//Tab(Constants.upcomingTab, systemImage: Constants.upcomingTabImage) {
//    UpcomingView()
//}
//Tab(Constants.searchTab, systemImage: Constants.searchTabImage) {
//    SearchView()
//}
//Tab(Constants.downloadTab, systemImage: Constants.downloadTabImage) {
//    DownloadView()
//}
//.badge(downloadShowModel.downloadedShowsCount)
