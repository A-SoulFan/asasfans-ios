//
//  PicView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct PicView: View {
    var url: String
    var body: some View {
        AsyncImage(url: URL(string: url), transaction: Transaction(animation: .easeOut))
        {
            phase in
            switch phase {
            case .success(let image):
                image.resizable()
                    .transition(.identity)
            case .empty:
                ProgressView()
            case .failure(_):
                Color.gray
            @unknown default:
                EmptyView()
            }
        }
    }
}
