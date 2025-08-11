//
//  PopularityBadgeView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

// PopularityBadgeView
struct PopularityBadgeView: View {
    let popularity: Double
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "flame.fill")
                .foregroundColor(.white)
                .imageScale(.small)
            
            Text(self.formatNumber(popularity))
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 14)
        .background(
            LinearGradient(
                colors: [Color.red, Color.orange],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}




#Preview {
    PopularityBadgeView(popularity: 44.0)
}
