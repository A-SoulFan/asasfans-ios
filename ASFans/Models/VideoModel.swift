//
//  VideoModel.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/7.
//

import Foundation

struct VideoModel {
    
    private(set) var videos: Array<SingleVideo>
    
    init(createVideoArray: (Array<VideoSingleResponse>) -> Array<SingleVideo>) {
        videos = []
    }
    
    mutating func flushVideos(videos multiVideos: [SingleVideo]) {
        videos = multiVideos + videos
    }
    
    struct SingleVideo: Identifiable, Decodable {
        var id = UUID()
        
        var pic: String
        var title: String
        var tagName: String
        var bvid: String
        var name: String
        var view: Int
        var like: Int
        var desc: String
    }
    
    
    func getDictionaryFromJSONString(jsonString: String) -> NSDictionary {
        let jsonData: Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    

    
    func initVideos(_ url: String) {
        print("test")
        let url: URL = URL(string: url)!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod =  "GET"
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let data = data, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            let dataString = String(data: data, encoding: String.Encoding.utf8)
            print(dataString!)
            let dict = self.getDictionaryFromJSONString(jsonString: dataString!)
            print(dict)
        }
        task.resume()
    }
    
}
