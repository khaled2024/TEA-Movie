//
//  SearchView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI


struct SearchView: View {
    // MARK: - Vars
    @State var vm = SearchViewModel()
    @State private var showDetailsPath = NavigationPath()
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $showDetailsPath){
            ScrollView {
                SearchViewText(searchString: $vm.searchString,searchPlaceholder: $vm.searchPlaceholder, isSearching: $vm.isSearching)
                    .onSubmit {
                        if vm.searchString.isEmpty && vm.switchToSeries {
                            vm.isSearching = false
                            Task{
                                await vm.fetchingSeries()
                            }
                        }
                        else if vm.searchString.isEmpty && !vm.switchToSeries {
                            vm.isSearching = false
                            Task{
                                await vm.fetchingMovies()
                            }
                        }
                        else{
                            vm.isSearching = true
                            vm.searchResults = []
                            Task{
                                if vm.switchToSeries {
                                    await vm.search(for: vm.searchString, type: "tv")
                                }else{
                                    await vm.search(for: vm.searchString, type: "movie")
                                }
                            }
                        }
                    }
                // search status
                switch vm.searchStatus {
                case .notStarted:
                    Text("Search not started!")
                        .foregroundColor(.secondary)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                case .loading:
                    LoadingView()
                        .controlSize(.regular)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                case .success , .fetchingMovies , .fetchingSeries:
                    
                    if vm.searchResults.isEmpty && vm.isSearching {
                        EmptyViewStatus(title: "No Results Found..!", imageName: "no-film")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }else{
                        LazyVGrid(columns: vm.columns, spacing: 10) {
                            ForEach(
                                vm.isSearching ? vm.searchResults : vm.switchToSeries ? vm.seriesResults : vm.moviesResults, id: \.self) { show in
                                    CustomAsyncImage(url: URL(string: show.posterImageURL), useCache: true, content: { movie in
                                        movie.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 120, height: 200)
                                            .cornerRadius(10)
                                    }, placeholder: {
                                        LoadingView()
                                            .controlSize(.regular)
                                            .frame(width: 120, height: 200)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(10)
                                    })
                                    .onTapGesture {
                                        showDetailsPath.append(show)
                                    }
                                }
                        }
                        .padding(.horizontal, 8)
                    }
                    
                case .failure(let error):
                    ErrorView(errorString: error.localizedDescription)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    
                }
            }
            .navigationTitle(Constants.searchNavTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: tapped) {
                        ToolbarBtn(switchToSeries: $vm.switchToSeries)
                    }
                }
            }
            .navigationDestination(for: ShowModel.self) { show in
                ShowDetailsView(show: show)
            }
        }
        .onAppear {
            if vm.searchResults.isEmpty {
                Task{
                    await vm.fetchingMovies()
                }
            }else{
                
            }
        }
    }
    // MARK: - Functions
    func tapped() {
        vm.switchToSeries.toggle()
        vm.searchString = ""
        vm.searchResults = []
        vm.searchPlaceholder = vm.switchToSeries ? "Search for series..!" : "Search for movies..!"
        Task{
            if vm.switchToSeries {
                await vm.fetchingSeries()
                
            } else {
                await vm.fetchingMovies()
            }
        }
    }
}
// MARK: - Preview
#Preview {
    NavigationStack{
        SearchView()
            .navigationTitle("Search")
    }
}

