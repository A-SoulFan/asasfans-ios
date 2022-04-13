//
//  SignUpView.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/10.
//

import SwiftUI

struct SignUpView: View {

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("登录")
                .font(.largeTitle).bold()
            Text("加入到一个魂的聚集地")
                .font(.headline)
            Button {

            } label: {
                Text("暂未开放用户功能")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.accentColor)
            .controlSize(.large)
            .disabled(true)
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: .black.opacity(0.2), radius: 30, x: 0, y: 30)
        .padding(20)
        .background(
            Image("signUpView").offset(x: -90).opacity(0.6)
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
