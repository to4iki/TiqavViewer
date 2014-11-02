//
//  TiqavAPI.swift
//  TiqavViewer
//
//  Created by to4iki on 11/2/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import Alamofire
import FranticApparatus

enum EntryPoint: String {
    case apiUrl = "http://api.tiqav.com/"
    case imageUrl = "http://img.tiqav.com/"
}

class TiqavAPI {
    
    /**
    promise rapping
    
    :param: method
    :param: URLString
    :param: parameters
    
    :returns: promsise
    */
    func request(method: Alamofire.Method, URLString: String, parameters: [String: AnyObject]? = nil) -> Promise<JSON> {
        let request = Alamofire.request(method, URLString, parameters: parameters)
        let promise = Promise<JSON>()
        
        request.responseJSON { (request, response, data, error) in
            let json = JSON(data!)
            promise.fulfill(json)
        }
        return promise
    }
}