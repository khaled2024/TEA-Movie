//
//  EmptyViewStatus.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import SwiftUI

struct EmptyViewStatus: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            Text(title)
                .font(.title)
                .foregroundColor(Color.gray)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    EmptyView()
}
