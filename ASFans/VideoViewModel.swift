//
//  VideoViewModel.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import SwiftUI

class VideoViewModel: ObservableObject {
    typealias Video = VideoModelPage.SingleVideo
    
    private static var videoArray: Array<Video> = []
    
    private static let baseUrl = "https://api.asasfans.asf.ink/v2/asoul-video-interface/advanced-search?order=pubdate&page=1&q=tag.%E4%B9%83%E7%90%B3+%E8%B4%9D%E6%8B%89.OR"
    
    private static func createVideoPage() -> VideoModelPage {
        VideoModelPage { index in
            var newVideoArray: [VideoModelPage.SingleVideo] = []
            for item in index {
                newVideoArray.append(VideoModelPage.SingleVideo(pic: item.pic.replacingOccurrences(of: "http", with: "https"), title: item.title, tagName: item.tname, bvid: item.bvid, name: item.name, view: item.view, like: item.like))
            }
            return newVideoArray
        }
    }
    
    @Published private var model = createVideoPage()
    
    var videos: Array<Video> {
        model.videos
    }
    
    func flushVideos(videos: [SingleResponse]) {
        var newVideoArray: [VideoViewModel.Video] = []
        for video in videos {
            newVideoArray.append(Video(pic: video.pic.replacingOccurrences(of: "http", with: "https"), title: video.title, tagName: video.tname, bvid: video.bvid, name: video.name, view: video.view, like: video.like))
        }
        model.flushVideos(videos: newVideoArray)
    }
    
}

struct VideoResponseData: Decodable {
    var page: Int
    var numResults: Int
    var result: [SingleResponse]
}

struct VideoResponse: Decodable {
    var code: Int
    var message: String
    var ttl: Int
    var data: VideoResponseData
}

struct SingleResponse: Decodable {
    var pic: String
    var title: String
    var tname: String
    var bvid: String
    var name: String
    var view: Int
    var like: Int
    
}
