//
//  ErrorView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct ErrorView: View {
    var errorString: String
    var retryAction: (() -> Void)?
    var body: some View {
        VStack(alignment: .center,spacing: 12){
            Image("error-message")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150, alignment: .center)
            
            Text("Error: \(errorString)")
                .foregroundColor(.gray)
                .bold()
                .multilineTextAlignment(.center)
            
            Button("Retry",systemImage: "arrow.trianglehead.clockwise") {
                retryAction?()
            }
            .primaryStyle(bgColor: Color.theme.redColor)
            .frame(width: 100, height: 50, alignment: .center)
        }
        .padding()
    }
}

#Preview {
    ErrorView(errorString: "error description here")
        
}
