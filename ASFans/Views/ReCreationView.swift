//
//  ReCreationView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct ReCreationView: View {
    @Environment(\.openURL) private var openURL
    
    @State var hasScrolled = true
    @State var page = 1
    @State var moreInfo = false
    
    @ObservedObject var reCreationViewModel: ReCreationViewModel
    
    func fetchPicDatas() async {
        do {
            let url = URL(string: "https://api.asoul.cloud:8000/getPic?page=\(page)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchJson: [ReCreationSingleResponse] = try JSONDecoder().decode([ReCreationSingleResponse].self, from: data)
            reCreationViewModel.reflushPics(pics: fetchJson)
        } catch let error {
            print(error)
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    List {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200, maximum: 187.5), spacing: 30), GridItem(.adaptive(minimum: 200, maximum: 187.5), spacing: 30)], spacing: 20) {
                            ForEach(reCreationViewModel.pics) { pic in
                                Button {
                                    if let url = URL(string: pic.img_src) {
                                        openURL(url)
                                    }
                                } label: {
                                    ZStack {
                                        let height = min(pic.img_height, 200)
                                        let width = min(pic.img_width, 200)
                                        RoundedRectangle(cornerRadius: 6).strokeBorder(lineWidth: 0.2).foregroundStyle(.secondary)
                                            .foregroundColor(.black)
                                            .frame(width: width+8, height: height+40)
                                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                                            .padding(.leading, 10)
                                            .padding(.trailing, 10)
                                        VStack {
                                            PicView(url: pic.img_src)
                                                .frame(width: width, height: height, alignment: .top)
                                                .aspectRatio(pic.img_width/pic.img_height, contentMode: .fill)
                                                .padding(.leading, 10)
                                                .padding(.trailing, 10)
                                            Text("\(pic.name)").foregroundColor(.primary)
                                        }
                                    }
                                }

                            }
                        }
                        .safeAreaInset(edge: .bottom, content: {
                            Color.clear.frame(height: 68)
                        })
                        }
                    }
                        .refreshable {
                            page += 1
                            await fetchPicDatas()
                        }
                    .listStyle(.plain)
                }
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
        .overlay(
            TopBar(title: "二创作品", hasScrolled: $hasScrolled)
        )
        .task {
            await fetchPicDatas()
        }
    }
}
