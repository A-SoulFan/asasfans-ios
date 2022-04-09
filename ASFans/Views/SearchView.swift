//
//  SearchView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/10.
//

import SwiftUI

struct SearchView: View {
    @State var text = ""
    @Environment(\.presentationMode) var persentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<5) { index in
                    Text("向晚")
                }
            }
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("大家都是一个魂捏🥰"))
            .navigationTitle("搜索")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button {
                persentationMode.wrappedValue.dismiss()
            } label: {
                Text("关闭").bold().foregroundColor(Color(hex: 0x9ac6e2))
            })
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
