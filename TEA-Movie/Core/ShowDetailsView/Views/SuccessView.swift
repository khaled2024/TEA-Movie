//
//  SuccessView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

// Success view
struct SuccessView: View {
    let vm: HomeViewModel
    let show: ShowModel?
    let releaseDate: String
    var downloadShowModel: DownloadShowModel
    @Binding var downloadTapped: Bool
    
    
    
    // MARK: - body
    var body: some View{
        
        ScrollView(.vertical) {
            LazyVStack {
                // YouTube Player for the show trailer/video
                YouTubePlayer(videoId: vm.videoID ?? "")
                    .aspectRatio(1.5, contentMode: .fit)
                
                // Title
                HStack{
                    Text(show?.title ?? show?.name ?? "Unknown Title")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    
                    PopularityBadgeView(popularity: show?.popularity ?? 0)
                    
                }
                .padding(10)
                
                // Overview
                Text(show?.overview ?? "Unknown Overview")
                    .font(.system(size: 18, weight: .medium, design: .default))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                
                // Rating Bar (using stars)
                RatingBar(rating: show?.voteAverage ?? 0)
                    .padding(.horizontal, 15)
                
                // Genres (displayed as tags)
                HStack(alignment: .center){
                    ForEach(show?.genreIDS ?? [], id: \.self) { genreID in
                        Text("Genre \(genreID)") // Assuming a genre fetch function exists
                            .font(.system(size: 14, weight: .medium))
                            .padding(8)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 15)
                
                // Air Date
                Text(releaseDate)
                    .font(.system(size: 16, weight: .regular, design: .default))
                    .padding(.horizontal, 15)
                    .foregroundStyle(.secondary)
                
                HStack(alignment: .center,spacing: 8){
                    DownloadButton()
                    // more info
                    Button(Constants.moreInfo, systemImage: Constants.info) {
                        
                    }
                    .primaryStyle(bgColor: Color.theme.greenColor,btnWidth: 130)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
            }
        }
    }
    // MARK: - DownloadButton
    @ViewBuilder
    func DownloadButton() -> some View {
        // download button
        let downloadedShowModel = downloadShowModel.downloadedShows
        if downloadedShowModel.contains(where: { $0.id == show?.id }) && !downloadTapped {
            Button("Downloaded", systemImage: "checkmark.circle.fill") {
                if let show = show{
                    // Remove from downloads
                    downloadShowModel.removeShowFromDownloads(show)
                }
            }
            .primaryStyle(bgColor: Color.black, btnWidth: 150)
            // .disabled(true)
            
        }else{
            if downloadTapped{
                LoadingView()
                    .frame(width: 60, height: 60)
            }
            else{
                Button(Constants.downloadTab, systemImage: Constants.downloadTabImage) {
                    if let show = show{
                        downloadShowModel.addShowToDownloads(show)
                        downloadTapped = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        downloadTapped = false
                    }
                }
                .primaryStyle(bgColor: Color.theme.redColor,btnWidth: 130)
            }
        }
    }
}
