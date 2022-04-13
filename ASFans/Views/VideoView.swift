//
//  VideoView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct VideoView: View {
    @Environment(\.openURL) private var openURL
    
    @State var hasScrolled = true
    @State var page = 1
    @State var moreInfo = false
    @State var currentVideo: VideoViewModel.Video? = nil
    
    @ObservedObject var videoViewModel: VideoViewModel
    
    func fetchVideoDatas() async {
        do {
            let url = URL(string: "https://api.asasfans.asf.ink/v2/asoul-video-interface/advanced-search?order=pubdate&page=\(page)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchJson: VideoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
            videoViewModel.flushVideos(videos: fetchJson.data.result)
            
        } catch let error {
            print(error)
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    List {
                    ForEach(videoViewModel.videos) { card in
                        Button {
                            withAnimation(.easeInOut) {
                                moreInfo = true
                                currentVideo = card
                            }
                        } label: {
                            OneCardView(card)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .coordinateSpace(name: "scroll")
                .listStyle(.plain)
                .frame(maxWidth: .infinity)
                .safeAreaInset(edge: .bottom, content: {
                    Color.clear.frame(height: 68)
                })
                .refreshable {
                    page += 1
                    await fetchVideoDatas()
                }
                }
                if moreInfo {
                    ZStack {
                        moreInfoCard
                    }
                    .zIndex(1)
                }
                Color.clear.preference(key: ScrollPreferenceKey.self,
                                       value: geometry.frame(in: .named("scroll")).minY)
                .frame(height: 0)
            }
        }

        .onPreferenceChange(ScrollPreferenceKey.self, perform: {
            value in
            withAnimation(.easeInOut) {
                if value - 143 < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
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
    var moreInfoCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(currentVideo!.title)
                    .font(.largeTitle).bold()
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        moreInfo = false
                    }
                }
            label:
                {
                    Image(systemName: "x.circle")
                    .imageScale(.large)
                    
                }
            }
            HStack {
                PicView(url: currentVideo!.pic)
                    .frame(width: CardConstant.width, height: CardConstant.height)
                Spacer()
                Text(currentVideo!.desc)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            Button {
                if let url = URL(string: "https://m.bilibili.com/video/" + currentVideo!.bvid) {
                    openURL(url)
                }
            } label: {
                Text("前往bilibili观看")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.accentColor)
            .controlSize(.large)
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: .black.opacity(0.2), radius: 30, x: 0, y: 30)
        .padding(20)
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
