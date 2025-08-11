//
//  ShowDetailsView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct ShowDetailsView: View {
    let show: ShowModel?
    @State var vm: HomeViewModel = HomeViewModel()
    
    var title: String {
        return show?.title ?? show?.name ?? "Unknown Title"
    }
    var releaseDate: String {
        return "First Air Date: \(show?.firstAirDate ?? show?.releaseDate ?? "Unknown Date")"
    }
    @EnvironmentObject var downloadShowModel: DownloadShowModel
    @State var downloadTapped: Bool = false

    // MARK: - body
    var body: some View {
        GeometryReader { geo in
            switch vm.videoStatus {
            case .notStarted:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            case .loading:
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            case .success:
                SuccessView(vm: vm, show: show, releaseDate: releaseDate, downloadShowModel: downloadShowModel, downloadTapped: $downloadTapped)
            case .failure(let error):
                ErrorView(errorString: error.localizedDescription) {
                    Task{
                        await vm.fetchVideoID(for: title)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
            }
        }
        .onAppear {
            if vm.videoID == nil || vm.videoID == "" {
                Task{
                    await vm.fetchVideoID(for: title)
                }
            }else{
                
            }
        }
    }
}
