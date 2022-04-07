//
//  TabBar.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab: Tab = .video
    @State var color: Color = Color(hex: 0x9ac6e2)
    @State var tabItemWidth: CGFloat = 0
    
    @ObservedObject var videoViewModel = VideoViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
                    switch selectedTab {
                    case .video:
                        VideoView(videoViewModel: videoViewModel)
                    case .reCreation:
                        ReCreationView()
                    case .voiceStudio:
                        VoiceStudioView()
                    case .tools:
                        ToolsView()
                }
            
            HStack{
                ForEach(tabItems) { item in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 1 )) {
                            selectedTab = item.tab
                            color = item.color
                        }
                    } label: {
                        VStack(spacing: 0) {
                            Image(systemName: item.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                            Text(item.text)
                                .font(.caption2)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                    .blendMode(selectedTab == item.tab ? .overlay : .normal)
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear.preference(key: TabPreferenceKey.self, value: geometry.size.width)
                        }
                    )
                    .onPreferenceChange(TabPreferenceKey.self) {
                        value in
                        tabItemWidth = value
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: 88, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 0, style: .continuous))
            .background(
                HStack {
                    if selectedTab == .tools { Spacer() }
                    if selectedTab == .reCreation { Spacer() }
                    if selectedTab == .voiceStudio {
                        Spacer()
                        Spacer()
                    }
                    Circle().fill(color).frame(width: tabItemWidth)
                    if selectedTab == .video { Spacer() }
                    if selectedTab == .reCreation {
                        Spacer()
                        Spacer()
                    }
                    if selectedTab == .voiceStudio { Spacer() }
                }
                .padding(.horizontal, 8)
            )
            .overlay(
                HStack {
                    if selectedTab == .tools { Spacer() }
                    if selectedTab == .reCreation { Spacer() }
                    if selectedTab == .voiceStudio {
                        Spacer()
                        Spacer()
                    }
                    Rectangle()
                        .fill(color)
                        .frame(width: 28, height: 5)
                        .cornerRadius(3)
                        .frame(width: tabItemWidth)
                        .frame(maxHeight: .infinity, alignment: .top)
                    if selectedTab == .video { Spacer() }
                    if selectedTab == .reCreation {
                        Spacer()
                        Spacer()
                    }
                    if selectedTab == .voiceStudio { Spacer() }
                }
                .padding(.horizontal, 8)
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
