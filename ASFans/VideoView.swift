//
//  VideoView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct VideoView: View {
    
    @State var hasScrolled = false
    
    @ObservedObject var videoViewModel: VideoViewModel
    
    func fetchVideoDatas() async {
        do {
            let url = URL(string: "https://api.asasfans.asf.ink/v2/asoul-video-interface/advanced-search?order=pubdate&page=1&q=tag.%E5%90%91%E6%99%9A.OR")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchJson: VideoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
            videoViewModel.flushVideos(videos: fetchJson.data.result)
            
        } catch let error {
            print(error)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(videoViewModel.videos) { card in
                    OneCardView(card)
                }
            }
            GeometryReader { geometry in
                Color.clear.preference(key: ScrollPreferenceKey.self,
                                       value: geometry.frame(in: .named("scroll")).minY)
            }
            .frame(height: 0)
            .refreshable {
                await fetchVideoDatas()
            }
        }
        .onPreferenceChange(ScrollPreferenceKey.self, perform: {
            value in
            withAnimation(.easeInOut) {
                if value < -10 {
                    hasScrolled = false
                } else {
                    hasScrolled = true
                }
            }
        })
        .coordinateSpace(name: "scroll")
        .safeAreaInset(edge: .top, content: {
            Color.clear.frame(height: 70)
        })
        .overlay(
            TopBar(title: "视频", hasScrolled: $hasScrolled)
        )
        .task {
            await fetchVideoDatas()
        }
    }
}

struct OneCardView: View {
    private let card: VideoViewModel.Video
    
    init(_ card: VideoViewModel.Video) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6).strokeBorder(lineWidth: 0.2).foregroundStyle(.secondary)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: CardConstant.height)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
            HStack(spacing: 0) {
                PicView(url: card.pic)
                    .frame(width: CardConstant.width, height: CardConstant.height)
                    .padding(.leading, 10)
                VStack(spacing: 0) {
                    Text(card.title)
                        .font(.system(size: 13, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing, 14)
                        .padding(.top, 5)
                        .padding(.bottom, 6)
                    Text(card.tagName)
                        .font(.caption2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                        .padding(.leading)
                        .foregroundColor(.secondary)
                    Text(card.name)
                        .font(.caption2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                        .padding(.leading)
                        .foregroundColor(.secondary)
                    HStack {
                        HStack(spacing: 0) {
                            Image(systemName: "play.square.fill")
                            Text("\(card.view) 播放")
                        }
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 5)
                            .padding(.leading)
                            .foregroundColor(.secondary)
                        HStack(spacing: 0) {
                            Image(systemName: "heart.fill")
                            Text("喜欢 \(card.like)")
                        }
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 5)
                            .padding(.trailing)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxHeight: CardConstant.height)
            }
            
        }
    }
}

struct CardConstant {
    static var width: CGFloat = 160
    static var height: CGFloat = 100
}
