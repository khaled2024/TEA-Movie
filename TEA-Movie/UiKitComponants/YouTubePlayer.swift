//
//  YouTubePlayer.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import SwiftUI
import WebKit

struct YouTubePlayer: UIViewRepresentable {
    let webView = WKWebView()
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView {
       
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let baseURL = URL(string: Constants.YOUTUBE_EMBED_URL) else {return}
        let youtubeURL = baseURL.appending(path: videoId)
        webView.load(URLRequest(url: youtubeURL))
    }
}

