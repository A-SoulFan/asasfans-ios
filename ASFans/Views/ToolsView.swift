//
//  ToolsView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct ToolsView: View {
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(asLinks) { aslink in
                        Link(destination: URL(string: aslink.URL)!) {
                            HStack {
                                PicView(url: aslink.logo)
                                    .frame(width: 20, height: 20)
                                    .padding(.leading, 10)
                                Text("\(aslink.name)")
                                Spacer()
                                Image(systemName: "link")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .accentColor(.primary)
            }
            .safeAreaInset(edge: .bottom, content: {
                Color.clear.frame(height: 68)
            })
            .navigationTitle("工具")
        }
    }
}

struct ASLinks: Identifiable {
    var id = UUID()
    var URL: String
    var name: String
    var logo: String
}

let asLinks: [ASLinks] = [
    ASLinks(URL: "http://asdb.live", name: "Asoul Database", logo: "https://livedb.asoulfan.com/web/icons/new_logo.png"),
    ASLinks(URL: "https://www.asoulworld.com/", name: "A-SOUL 导航站", logo: "https://www.asoulworld.com/favicon.ico"),
    ASLinks(URL: "https://nf.asoul-rec.com", name: "A-SOUL原画录播站", logo: "https://wkphoto.cdn.bcebos.com/a8ec8a13632762d003a1b9dbb0ec08fa513dc633.jpg"),
    ASLinks(URL: "https://asoul.cloud/", name: "一个魂的二创", logo: "https://asoul.cloud/favicon.ico"),
    ASLinks(URL: "https://landing.asoulwiki.com/AsoulArt", name: "Asoul 二创爬虫收集", logo: "https://file.alexhaohao.com/ojaFGoeEgIN0lXumlSUeJyMbGsk2JFm5/logo%20%281%29.webp"),
    ASLinks(URL: "https://asoulfan.com/", name: "ASOULFAN", logo: "https://www.asoulworld.com/favicon.ico"),
    ASLinks(URL: "https://online.asoulfan.com/", name: "AU都在溜什么？", logo: "https://www.asoulworld.com/favicon.ico"),
    ASLinks(URL: "https://pic.asoulfan.com/", name: "A-SOUL搜图姬", logo: "https://pic.asoulfan.com/assets/favicon.60c72708.svg"),
    ASLinks(URL: "https://livedb.asoulfan.com/PhotoSearch/index.html", name: "ASOUL图片检索", logo: "https://www.asoulworld.com/favicon.ico"),
    ASLinks(URL: "https://asoulcnki.asia/", name: "枝网查重", logo: "https://asoulcnki.asia/pwa-192x192.png"),
    ASLinks(URL: "https://asoulwiki.com/", name: "一个魂维基 A-SOUL WIKI", logo: "https://asoulwiki.com/favicon.ico"),
    ASLinks(URL: "https://asoul.icu/", name: "🍬小作文", logo: "https://asoul.icu/logo.ico"),
    ASLinks(URL: "https://asoulbook.top/", name: "枝江方言词典", logo: "https://asoulbook.top/img/LOGO3.png"),
    ASLinks(URL: "https://asoul.jp", name: "A-SOUL 非公式ファンサイト", logo: "https://asoul.jp/res/favicon.ico"),
    ASLinks(URL: "https://p2p.bbs.asf.ink/", name: "A-SOUL PT站", logo: "https://test.pt.asf.ink/favicon.ico"),
    ASLinks(URL: "https://asbbs.vtb.link/", name: "A-SOUL BBS", logo: "https://asbbs.vtb.link/favicon.ico"),
    ASLinks(URL: "https://jiawanfan.cn/", name: "嘉晚饭", logo: "https://jiawanfan.cn/favicon.ico"),
    ASLinks(URL: "https://zhijiang.university/", name: "枝江大学", logo: "https://zhijiang.university/favicon.ico"),
    ASLinks(URL: "http://asoulfans.xyz/", name: "A-Soul Fans Global", logo: "https://www.asoulworld.com/favicon.ico"),
    ASLinks(URL: "https://asoul.asia/", name: "ASOUL论坛管理群聊天记录公式", logo: "https://www.asoulworld.com/favicon.ico"),
    ASLinks(URL: "https://asoul.video", name: "A-SOUL Video", logo: "https://www.asoulworld.com/favicon.ico"),
    ASLinks(URL: "https://music.163.com/#/djradio?id=964463470", name: "网易云音乐电台", logo: "https://s1.music.126.net/style/favicon.ico"),
    ASLinks(URL: "https://vtbkeyboard.moe/672328094", name: "嘉然声音按钮", logo: "https://vtbkeyboard.moe/api/icon/672328094.png"),
    ASLinks(URL: "http://asoul.infedg.xyz/", name: "小作文生成器", logo: "https://asoul.infedg.xyz/favicon.ico"),
]
