//
//  AccountView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/10.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            List {
                VStack(spacing: 8) {
                    Image(systemName: "person")
                        .symbolVariant(.circle)
                        .font(.system(size: 32))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(myColor, myColor.opacity(0.3))
                        .padding()
                        .background(Circle().fill(.ultraThinMaterial))
                        .background(
                            Image(systemName: "hexagon")
                                .symbolVariant(.fill)
                                .foregroundColor(myColor.opacity(0.6))
                                .font(.system(size: 200))
                                .offset(x: -50, y: -100)
                        )
                    Text("一个魂")
                        .font(.title.weight(.semibold))
                    HStack {
                        Image(systemName: "music.quarternote.3")
                            .imageScale(.small)
                        Text("A-Soul")
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                Section {
                    Label("设置", systemImage: "gear")
                        .accentColor(myColor)
                    Text("Others")
                    Label("关于", systemImage: "text.alignleft")
                        .accentColor(myColor)

                }
                .listRowSeparatorTint(myColor)
                .listRowSeparator(.hidden)
            }
            .listStyle(.insetGrouped)
            .navigationTitle(Text("Account"))
        }
    }
}
