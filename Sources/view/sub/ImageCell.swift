//
//  ImageCell.swift
//  TiqavViewer
//
//  Created by to4iki on 11/3/14.
//  Copyright (c) 2014 to4iki. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet private weak var tiqavImage: UIImageView!
    
    class func defaultHeight() ->  CGFloat {
        return 200
    }
    
    func configure(image: Image) {
        self.tiqavImage.sd_setImageWithURL(NSURL(string: image.url))
    }
}
