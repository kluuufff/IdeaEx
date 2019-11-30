//
//  WebViewController.swift
//  IdeaEx
//
//  Created by Надежда Возна on 30.11.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    public var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        thisURLstr = urlString
        guard let testURL = URL(string: urlString) else { return }
        let testURLRequest = URLRequest(url: testURL)
        webView.loadRequest(testURLRequest)
        
    }

}
