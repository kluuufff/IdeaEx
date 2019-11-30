//
//  JsonModel.swift
//  IdeaEx
//
//  Created by Надежда Возна on 30.11.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import Foundation

//"{\"data\":{\"link\":\"https:\\/\\/i.imgur.com\\/CuqLv1n.jpg\"}"

struct getLink: Codable {
    let data: allData
}

struct allData: Codable {
    let link: String
}
