//
//  VoiceStudioView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI
import WebKit

struct VoiceStudioView: View {
    
    var body: some View {
        HStack {
            WebView(request: URLRequest(url: URL(string: "https://studio.asf.ink/")!))
        }

    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.load(request)
    }
}
