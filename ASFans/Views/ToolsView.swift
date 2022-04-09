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
                    Link(destination: URL(string: "https://asoulcnki.asia/")!) {
                        HStack {
                            PicView(url: "https://asoulcnki.asia/favorite.svg")
                                .frame(width: 20, height: 20)
                                .padding(.leading, 10)
                            Text("枝网查重")
                            Spacer()
                            Image(systemName: "link")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                }
                .accentColor(.primary)
            }
            .navigationTitle("工具")
        }
    }
}

