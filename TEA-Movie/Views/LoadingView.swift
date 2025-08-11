//
//  LoadingView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI
struct LoadingView: View {
    var body: some View {
        ZStack{
            Color.theme.gradientColor
                .ignoresSafeArea()
            LottieView(name: "loadingAnimation-red", loopMode: .loop)
                .frame(width: 80, height: 80, alignment: .center)
        }
    }
}
#Preview {
    LoadingView()
}
