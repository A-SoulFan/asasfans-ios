//
//  ReCreationView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

struct ReCreationView: View {
    
    var body: some View {
        HStack {
            PicScroll()
        }
    }
}

struct PicScroll: View {
    var body: some View {
        ScrollView {
            Rectangle()
        }
    }
}
