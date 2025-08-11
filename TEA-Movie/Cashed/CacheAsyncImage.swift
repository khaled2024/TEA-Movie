//
//  CacheAsyncImage.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//

import Foundation
import SwiftUI


struct CustomAsyncImage<Content: View, Placeholder: View>: View {
    let url: URL?
    let useCache: Bool
    let content: (Image) -> Content
    let placeholder: () -> Placeholder

    @State private var loadedImage: Image? = nil

    var body: some View {
        Group {
            if let image = loadedImage {
                content(image)
            } else {
                placeholder()
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .onChange(of: url) { _ in
            loadedImage = nil
            loadImage()
        }
    }

    private func loadImage() {
        guard let url = url else { return }

        let request = URLRequest(
            url: url,
            cachePolicy: useCache ? .returnCacheDataElseLoad : .reloadIgnoringLocalCacheData
        )

        // Check cached response
        if useCache,
           let cached = URLCache.shared.cachedResponse(for: request),
           let cachedImage = UIImage(data: cached.data) {
            self.loadedImage = Image(uiImage: cachedImage)
            return
        }

        // Fetch from network
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response,
                  let downloadedImage = UIImage(data: data) else {
                return
            }

            if useCache {
                let cachedData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedData, for: request)
            }

            let swiftUIImage = Image(uiImage: downloadedImage)

            DispatchQueue.main.async {
                self.loadedImage = swiftUIImage
            }

        }.resume()
    }
}
