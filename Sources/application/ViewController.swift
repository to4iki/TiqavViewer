//
//  ViewController.swift
//  TiqavViewer
//
//  Created by to4iki on 11/2/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import UIKit
import FranticApparatus

struct ImageViewScope {
    var images: [Image] = []
}

class ViewController: UITableViewController {
    
    var searchPromis: Promise<[Image]>?
    var scope: ImageViewScope = ImageViewScope() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        randomLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Load
    
    func randomLoad() {
        let service = ImageService()
        
        searchPromis = service.random().when({ (images: [Image]) in
            var prefetchImages: [String] = []
            
            for i in images {
                prefetchImages.append(i.url)
            }
            self.scope.images = images
            SDWebImagePrefetcher.sharedImagePrefetcher().prefetchURLs(prefetchImages)
        }).finally({
            self.searchPromis = nil
        })
    }
    
    // MARK: Table
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scope.images.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.imageView.sd_setImageWithURL(NSURL(string: scope.images[row].url))
        
        return cell
    }
}
