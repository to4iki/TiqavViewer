//
//  SearchAPI.swift
//  TiqavViewer
//
//  Created by to4iki on 11/2/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import Alamofire
import FranticApparatus

class SearchAPI {
    
    private let api: TiqavAPI
    private let url: String
    
    init(api: TiqavAPI = TiqavAPI(), url: String = EntryPoint.apiUrl.rawValue) {
        self.api = api
        self.url = url
    }
    
    func search(#q: String) -> Promise<JSON> {
        let u = url + "search.json"
        return api.request(.GET, URLString: u, parameters: ["q": q])
    }
    
    func random() -> Promise<JSON> {
        let u = url + "search/random.json"
        return api.request(.GET, URLString: u)
    }
}