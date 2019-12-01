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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    let fadeView: UIView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        imageView.addSubview(fadeView)
//        fadeView.frame = imageView.frame
//        fadeView.backgroundColor = .black
//        fadeView.center.x = imageView.center.x
//        fadeView.center.y = imageView.center.y
//        fadeView.alpha = 0.6
//        fadeView.isHidden = true
        
    }
}
