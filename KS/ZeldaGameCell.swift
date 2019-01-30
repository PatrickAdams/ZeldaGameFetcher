//
//  ZeldaGameCell.swift
//  KS
//
//  Created by Patrick Adams on 1/30/19.
//  Copyright © 2019 Sure, Inc. All rights reserved.
//

import UIKit

class ZeldaGameCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageThumb: UIImageView!
    
    var zeldaGame: ZeldaGame? {
        didSet {
            titleLabel.text = zeldaGame?.name
            descriptionLabel.text = zeldaGame?.info
            imageThumb.imageFromServerURL(urlString: (zeldaGame?.thumbUrl)!)
        }
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}

extension UIView {
    public func roundCorners(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
