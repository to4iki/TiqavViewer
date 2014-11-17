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

class ViewController: UITableViewController, NJKScrollFullscreenDelegate {

    @IBOutlet private weak var reloadButton: UIButton!
    
    var searchPromis: Promise<[Image]>?
    var scope: ImageViewScope = ImageViewScope() {
        didSet {
            tableView.reloadData()
            refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        
        var scrollProxy = NJKScrollFullScreen(forwardTarget: self.tableView)
        tableView.delegate = scrollProxy as? UITableViewDelegate
        scrollProxy.delegate = self
        
        initLaoyout()
        initDocument()
        addHandlers()
        randomLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Document
    
    private func initDocument() {
        self.title = "TiqavViewer"
    }
    
    private func initLaoyout() {
        self.navigationController?.navigationBar.barTintColor = TiqavColor.main.toColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    // MARK: Handler
    
    func addHandlers() {
        refreshControl?.addTarget(self, action: "execReload", forControlEvents: .ValueChanged)
        reloadButton.addTarget(self, action: "execReload", forControlEvents: .TouchUpInside)
    }
    
    func execReload() {
        randomLoad()
    }
    
    // MARK: Load
    
    private func randomLoad() {
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
        return ImageCell.defaultHeight()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "imageCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId) as ImageCell
        cell.configure(scope.images[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let text = scope.images[indexPath.row].url
        
        let alert = UIAlertController(title: "taped", message: text, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "close", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: NJKScrollFullScreen

    func scrollFullScreen(fullScreenProxy: NJKScrollFullScreen!, scrollViewDidScrollUp deltaY: CGFloat) {
        self.moveNavigationBar(deltaY, animated: true)
    }
    
    func scrollFullScreen(fullScreenProxy: NJKScrollFullScreen!, scrollViewDidScrollDown deltaY: CGFloat) {
        self.moveNavigationBar(deltaY, animated: true)
    }
    
    func scrollFullScreenScrollViewDidEndDraggingScrollUp(fullScreenProxy: NJKScrollFullScreen!) {
        self.hideNavigationBar(true)
    }
    
    func scrollFullScreenScrollViewDidEndDraggingScrollDown(fullScreenProxy: NJKScrollFullScreen!) {
        self.showNavigationBar(true)
    }
}
