//
//  RatingBar.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

// Rating Bar Component
struct RatingBar: View {
    var rating: Double
    
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < Int(rating / 2) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .font(.system(size: 20))
            }
        }
        .padding(.vertical, 10)
    }
}


#Preview {
    RatingBar(rating: 9.0)
}
