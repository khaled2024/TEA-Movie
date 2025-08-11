//
//  ToolbarBtn.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import SwiftUI

struct ToolbarBtn: View {
    @Binding var switchToSeries: Bool
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: switchToSeries ? "tv" : "film")
            Text(switchToSeries ? "Series" : "Movies")
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color.theme.redColor.opacity(0.15))
        .foregroundColor(Color.theme.redColor)
        .font(.system(size: 14, weight: .medium))
        .clipShape(Capsule())
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 0)
    }
}

#Preview {
    ToolbarBtn(switchToSeries: .constant(true))
}
