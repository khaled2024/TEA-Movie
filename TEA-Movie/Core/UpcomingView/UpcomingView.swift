//
//  UpcomingView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct UpcomingView: View {
    @StateObject private var vm = UpcomingViewModel()
    @State private var showDetailsPath = NavigationPath()
    // MARK: - body
    var body: some View {
        NavigationStack(path: $showDetailsPath) {
            GeometryReader { geo in
                switch vm.upcomingStatus {
                case .notStarted:
                    LoadingView()
                        .frame(width: geo.size.width, height: geo.size.height,alignment: .center)
                case .loading:
                    LoadingView()
                        .frame(width: geo.size.width, height: geo.size.height,alignment: .center)
                case .success:
                    List {
                        ForEach(vm.upcomingMovies) { show in
                            ListRowView(show: show)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .onTapGesture {
                                    showDetailsPath.append(show)
                                }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle(Constants.upcomingNavTitle)
                    .navigationBarTitleDisplayMode(.large)
                    .background(Color.clear)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: ShowModel.self) { showDetails in
                        ShowDetailsView(show: showDetails)
                    }
                case .failure(let error):
                    ErrorView(errorString: error.localizedDescription) {
                        Task {
                            await vm.fetchUpcomingMovies()
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height,alignment: .center)
                }
            }
        }
        .onAppear{
            Task{
                await vm.fetchUpcomingMovies()
            }
        }
    }
    
}

#Preview {
    UpcomingView()
}
