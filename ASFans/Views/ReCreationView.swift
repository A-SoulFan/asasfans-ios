//
//  ReCreationView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct ReCreationView: View {
    
    var body: some View {
        NavigationView {
            PicScroll()
            
            .navigationTitle("二创图片")
        }

    }
}

struct PicScroll: View {
    var body: some View {
        ScrollView {
            Text("二创图片")
        }
    }
}
