//
//  CollectionViewCell.swift
//  IdeaEx
//
//  Created by Надежда Возна on 29.11.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
//    let activityView = UIActivityIndicatorView(style: .whiteLarge)
//    let fadeView: UIView = UIView()
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        imageView.addSubview(fadeView)
//        fadeView.frame = imageView.frame
//        fadeView.backgroundColor = .black
//        fadeView.center.x = imageView.center.x
//        fadeView.center.y = imageView.center.y
//        fadeView.alpha = 0.6
//        fadeView.isHidden = true
//
//        fadeView.addSubview(activityView)
//        activityView.hidesWhenStopped = true
//        activityView.center = fadeView.center
//        
//    }
//    public func spinnerStart() {
//        fadeView.isHidden = false
//        activityView.startAnimating()
//    }
//    public func spinnerStop() {
//        fadeView.isHidden = true
//        activityView.stopAnimating()
//    }
}
