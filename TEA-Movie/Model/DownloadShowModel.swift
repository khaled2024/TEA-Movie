//
//  DownloadShowModel.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import SwiftUI

class DownloadShowModel: ObservableObject {
    @Published var downloadedShows: [ShowModel] = []
    
    func addShowToDownloads(_ show: ShowModel) {
        downloadedShows.append(show)
    }
    func delete(offset: IndexSet) {
        withAnimation {
            downloadedShows.remove(atOffsets: offset)
        }
        
    }
    func removeShowFromDownloads(_ show: ShowModel) {
        if let index = downloadedShows.firstIndex(where: { $0.id == show.id }) {
            downloadedShows.remove(at: index)
        }
    }
    var downloadedShowsCount: Int {
        return downloadedShows.count
    }
        
        
    
}
