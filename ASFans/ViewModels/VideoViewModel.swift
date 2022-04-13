//
//  VideoViewModel.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

class VideoViewModel: ObservableObject {
    typealias Video = VideoModel.SingleVideo
    
    private static var videoArray: Array<Video> = []

    
    private static func createVideoPage() -> VideoModel {
        VideoModel { index in
            var newVideoArray: [Video] = []
            for item in index {
                newVideoArray.append(Video(pic: item.pic.replacingOccurrences(of: "http", with: "https"), title: item.title, tagName: item.tname, bvid: item.bvid, name: item.name, view: item.view, like: item.like, desc: item.desc))
            }
            return newVideoArray
        }
    }
    
    @Published private var model = createVideoPage()
    
    var videos: Array<Video> {
        model.videos
    }
    
    func flushVideos(videos: [VideoSingleResponse]) {
        var newVideoArray: [Video] = []
        for video in videos {
            newVideoArray.append(Video(pic: video.pic.replacingOccurrences(of: "http", with: "https"), title: video.title, tagName: video.tname, bvid: video.bvid, name: video.name, view: video.view, like: video.like, desc: video.desc))
        }
        model.flushVideos(videos: newVideoArray)
    }
    
}

struct VideoResponseData: Decodable {
    var page: Int
    var numResults: Int
    var result: [VideoSingleResponse]
}

struct VideoResponse: Decodable {
    var code: Int
    var message: String
    var ttl: Int
    var data: VideoResponseData
}

struct VideoSingleResponse: Decodable {
    var pic: String
    var title: String
    var tname: String
    var bvid: String
    var name: String
    var view: Int
    var like: Int
    
    var desc: String
}
