//
//  HorizontalListView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct HorizontalListView: View {
    let headerTitle: String
    let shows: [ShowModel]
    let onSelect: (ShowModel) -> Void
    var seeMoreAction: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(headerTitle)
                    .font(.system(size: 23, weight: .heavy, design: .default))
                    .bold()
                    .padding(.leading, 10)
                Spacer()
                
                Button("See more") {
                    // Action for "See more" button
                    seeMoreAction?()
                }
                .tint(Color.theme.redColor)
                .font(.system(size: 13, weight: .bold, design: .default))
                .padding(.trailing, 10)
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(shows, id: \.self) { show in
                        CustomAsyncImage(url: URL(string: show.posterImageURL), useCache: true) { movie in
                            movie.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 200)
                                .cornerRadius(10)
                                .padding(.horizontal, 5)
                        } placeholder: {
                            LoadingView()
                                .controlSize(.regular)
                                .frame(width: 150, height: 200)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                        .onTapGesture {
                            onSelect(show)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .frame(height: 260)
    }
}
