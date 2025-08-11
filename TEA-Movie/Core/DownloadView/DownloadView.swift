//
//  DownloadView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct DownloadView: View {
    @EnvironmentObject var downloadShowModel: DownloadShowModel
    @State private var showDetailsPath = NavigationPath()
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $showDetailsPath) {
            if downloadShowModel.downloadedShows.isEmpty {
                EmptyViewStatus(title: "No Downloaded Shows..!", imageName: "no-film")
                
            }else{
                List{
                    ForEach(downloadShowModel.downloadedShows) { show in
                        ListRowView(show: show)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .onTapGesture {
                                showDetailsPath.append(show)
                            }
                    }
                    .onDelete(perform: downloadShowModel.delete(offset: ))
                }
                .navigationTitle(Constants.downloadNavTitle)
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.large)
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                .navigationDestination(for: ShowModel.self) { showDetails in
                    ShowDetailsView(show: showDetails)
                }
            }
        }
        
    }
}

#Preview {
    DownloadView()
}
