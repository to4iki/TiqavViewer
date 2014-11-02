//
//  ImageService.swift
//  TiqavViewer
//
//  Created by to4iki on 11/3/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import Alamofire
import FranticApparatus

class ImageService {

    private let serchAPI: SearchAPI
    
    init(serchAPI: SearchAPI = SearchAPI()) {
        self.serchAPI = serchAPI
    }
    
    func serch(q: String) -> Promise<[Image]> {
        return serchAPI.search(q: q).when({ (res: JSON) -> Result<[Image]> in
            var result: [Image] = []
            if let images = res.asArray {
                
                for json in images {
                    let image = Image(json: json)
                    result.append(image!)
                }
            }
            return .Success(result)
        })
    }
    
    func random() -> Promise<[Image]> {
        return serchAPI.random().when({ (res: JSON) -> Result<[Image]> in
            var result: [Image] = []
            if let images = res.asArray {
                
                for json in images {
                    let image = Image(json: json)
                    result.append(image!)
                }
            }
            return .Success(result)
        })
    }
}
