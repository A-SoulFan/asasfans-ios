//
//  Tab.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "视频", icon: "video.fill", tab: .video, color: Color(hex: 0x9ac6e2)),
    TabItem(text: "二创图片", icon: "photo.fill.on.rectangle.fill", tab: .reCreation, color: Color(hex: 0x9ac6e2)),
    TabItem(text: "录音棚", icon: "music.note.house", tab: .voiceStudio, color: Color(hex: 0x9ac6e2)),
    TabItem(text: "工具", icon: "filemenu.and.selection", tab: .tools, color: Color(hex: 0x9ac6e2))
]

enum Tab: String {
    case video
    case reCreation
    case voiceStudio
    case tools
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
