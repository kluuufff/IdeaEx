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
    
    //MARK: - Get image from Photo Library
    
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
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - TapGesture Method
    
    @objc func cellTappedMethod(_ sender: AnyObject){
        print("you tap image number: \(sender.view.tag)")
        print("image: \(imageArray[sender.view.tag])")

        uploadImage(image: imageArray[sender.view.tag])
    }
    
    //MARK: - Get Link from JSON
    
    private func parseJson(exampleJson: String) {
        let jsonData = Data(exampleJson.utf8)
        
        do {
            let decoder = JSONDecoder()
            let finalData = try decoder.decode(getLink.self, from: jsonData)
            print("finalData: \(finalData.data.link)")
        } catch let error {
            print(error)
        }
    }
    
    //MARK: - Upload image to IMGUR
    
    func uploadImage(image: UIImage) {
        let chosenImage = image
        let imageData = chosenImage.jpegData(compressionQuality: 1)
        guard let uploadUrlString = URL(string: "https://api.imgur.com/3/upload") else { return }
        
        var postRequest = URLRequest(url: uploadUrlString)
        postRequest.addValue("Client-ID 15cffe374dc85b8", forHTTPHeaderField: "Authorization")
        postRequest.httpMethod = "POST"
        postRequest.httpBody = imageData
        
        let uploadSession = URLSession.shared
        
        let executePostRequest = uploadSession.dataTask(with: postRequest as URLRequest) { (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    print(response.statusCode)
                }
                if let data = data {
                    guard let json = String(data: data, encoding: String.Encoding.utf8) else { return }
                    
                    self.parseJson(exampleJson: json)
                    
                    #if DEBUG
                    print("Response data: \(String(describing: json))")
                    #endif
                }
            }
        }
        executePostRequest.resume()
        
    }
    
    //collectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
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
