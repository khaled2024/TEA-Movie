//
//  ListRowView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct ListRowView: View {
    let show: ShowModel?
    var body: some View {
        HStack(spacing: 10) {
            // image
            CustomAsyncImage(url: URL(string: show?.posterImageURL ?? ""), useCache: true, content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 150)
                    .cornerRadius(10)
                    .padding(8)
            }, placeholder: {
                LoadingView()
                    .frame(width: 120, height: 150)
                    .cornerRadius(10)
                    .padding(8)
            })
           
            // title
            Text(show?.title ?? show?.name ?? "Unknown Title")
                .font(.headline)
                .bold()
                .lineLimit(2)
                .foregroundColor(.primary)
                .padding(.trailing , 8)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
        )
        .frame(maxWidth: .infinity)
    }
}
