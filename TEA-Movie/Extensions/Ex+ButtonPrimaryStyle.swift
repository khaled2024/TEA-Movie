//
//  Ex+ButtonPrimaryStyle.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import SwiftUI

extension Button{
    func primaryStyle(bgColor: Color,btnWidth: CGFloat? = 100 , btnHeight: CGFloat? = 50) -> some View {
        self
            .frame(width: btnWidth, height: btnHeight)
            .background(bgColor)
            .foregroundColor(.white)
            .cornerRadius(13)
            .bold()
            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 0)
    }
}
