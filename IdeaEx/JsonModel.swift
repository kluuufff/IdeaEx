//
//  JsonModel.swift
//  IdeaEx
//
//  Created by Надежда Возна on 30.11.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import Foundation

//"{\"data\":{\"link\":\"https:\\/\\/i.imgur.com\\/CuqLv1n.jpg\"}"

let exampleJson = """
"{
\"data\":
    {\"id\":\"CuqLv1n\",
     \"title\":null,
     \"description\":null,
     \"datetime\":1575067102,
     \"type\":\"image\\/jpeg\",
     \"animated\":false,
     \"width\":200,
     \"height\":150,
     \"size\":58720,
     \"views\":0,
     \"bandwidth\":0,
     \"vote\":null,
     \"favorite\":false,
     \"nsfw\":null,
     \"section\":null,
     \"account_url\":null,
     \"account_id\":0,
     \"is_ad\":false,
     \"in_most_viral\":false,
     \"has_sound\":false,
     \"tags\":[],
     \"ad_type\":0,
     \"ad_url\":\"\",
     \"edited\":\"0\",
     \"in_gallery\":false,
     \"deletehash\":\"SOjGUT1PFT95v35\",
     \"name\":\"\",
     \"link\":\"https:\\/\\/i.imgur.com\\/CuqLv1n.jpg\"
    },
\"success\":true,
\"status\":200
}"
"""

struct getLink: Codable {
    let data: allData
}

struct allData: Codable {
    let link: String
    enum CodingKeys: String, CodingKey {
        case link = "link"
    }
}
