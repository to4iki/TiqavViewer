//
//  Image.swift
//  TiqavViewer
//
//  Created by to4iki on 11/2/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

class Image {
    
    let id: String
    let ext: String
    let height: Int
    let width: Int
    let source_url: String
    
    var url: String {
        get {
            return EntryPoint.imageUrl.rawValue + id + "." + ext
        }
    }
    
    init(id: String, ext: String, height: Int, width: Int, source_url: String) {
        self.id = id
        self.ext = ext
        self.height = height
        self.width = width
        self.source_url = source_url
    }
    
    init?(json: JSON) {
        switch (
            json["id"].asString,
            json["ext"].asString,
            json["height"].asInt,
            json["width"].asInt,
            json["source_url"].asString
        ) {
        case (
            let .Some(_id),
            let .Some(_ext),
            let .Some(_height),
            let .Some(_width),
            let .Some(_source_url)
            ):
            self.id = _id
            self.ext = _ext
            self.height = _height
            self.width = _width
            self.source_url = _source_url
        default:
            self.id = ""
            self.ext = ""
            self.height = 0
            self.width = 0
            self.source_url = ""
            return nil
        }
    }
}
