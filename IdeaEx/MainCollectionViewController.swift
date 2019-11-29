//
//  ViewController.swift
//  IdeaEx
//
//  Created by Надежда Возна on 27.11.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit
import Photos

class MainCollectionViewController: UICollectionViewController {
    
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
    }
    
    private func getImage() {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            for i in 0..<fetchResult.count {
                imageManager.requestImage(for: fetchResult.object(at: i) as PHAsset,
                                          targetSize: CGSize(width: 150, height: 150),
                                          contentMode: .aspectFill,
                                          options: requestOptions,
                                          resultHandler: { (image, _) in
                    if let image = image {
                        self.imageArray.append(image)
                    }
                })
            }
        } else {
            print("error")
            collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    @objc func cellTappedMethod(_ sender:AnyObject){
        print("you tap image number: \(sender.view.tag)")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imageView.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
        cell.imageView.image = imageArray[indexPath.row]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTappedMethod(_:)))

        cell.imageView.isUserInteractionEnabled = true
        cell.imageView.tag = indexPath.row
        cell.imageView.addGestureRecognizer(tapGestureRecognizer)
        
        return cell
    }
    
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let orientation = UIApplication.shared.statusBarOrientation
        let sizeForLandscape = collectionView.frame.width / 5 - 1
        let sizeForPortrait = collectionView.frame.width / 3 - 1
        if(orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            return CGSize(width: sizeForLandscape, height: sizeForLandscape)
        }
        else {
            return CGSize(width: sizeForPortrait, height: sizeForPortrait)
        }
    }

}
