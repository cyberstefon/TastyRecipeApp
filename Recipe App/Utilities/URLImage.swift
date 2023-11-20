//
//  URLImage.swift
//  Recipe App
//
//  Created by Stefon Gholston on 11/16/23.
//

import SwiftUI

struct URLImage: View {
    let url: String

    var body: some View {
        if let imageUrl = URL(string: url) {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.gray)
                case .empty:
                    ProgressView()
                @unknown default:
                    // Handle any future cases here
                    EmptyView()
                }
            }
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .foregroundColor(.gray)
        }
    }
}
