//
//  ReCreationModel.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/13.
//

import Foundation

struct ReCreationModel {
    
    private(set) var picArray: Array<SingleReCreationPic>
    
    init(createPicArray: (Array<ReCreationSingleResponse>) -> Array<SingleReCreationPic>) {
        picArray = []
    }
    
    struct SingleReCreationPic: Identifiable, Decodable {
        var id = UUID()
        
        var img_src: String
        var img_width: Double
        var img_height: Double
        
        var name: String
    }
    
    mutating func flushPicArray(newPics: [SingleReCreationPic]) {
        picArray = newPics + picArray
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
