//
//  ReCreationViewModel.swift
//  ASFans
//
//  Created by 言临川 on 2022/4/13.
//

import SwiftUI

class ReCreationViewModel: ObservableObject {
    typealias Pic = ReCreationModel.SingleReCreationPic
    
    private(set) var picArray:[Pic] = []
    
    private static func createReCreationPage() -> ReCreationModel {
        ReCreationModel { index in
            var newPicArray: [Pic] = []
            for item in index {
                newPicArray.append(Pic(img_src: item.pic_url.first!.img_src, img_width: item.pic_url.first!.img_width, img_height: item.pic_url.first!.img_height, name: item.name))
            }
            return newPicArray
        }
    }
    
    var pics: Array<Pic>{
        model.picArray
    }
    
    @Published private var model = createReCreationPage()
    
    func reflushPics(pics: [ReCreationSingleResponse]) {
        var newPicArray: [Pic] = []
        for pic in pics {
            newPicArray.append(Pic(img_src: pic.pic_url.first!.img_src, img_width: pic.pic_url.first!.img_width, img_height: pic.pic_url.first!.img_height, name: pic.name))
        }
        model.flushPicArray(newPics: newPicArray)
    }
}

struct ReCreationSingleResponse: Decodable {
    var dy_id: String
    var uid: Int
    var name: String
    var face: String
    
    var pic_url: Array<ReCreationSingleImageData>
}

struct ReCreationSingleImageData: Decodable {
    var img_src: String
    var img_size: Double
    var img_tags: String?
    var img_width: Double
    var img_height: Double
}
