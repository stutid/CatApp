//
//  CatModel.swift
//  CatApp
//
//  Created by Stuti on 03/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

struct Cat: Decodable, Equatable, ListType {
    var id: String?
    var url: URL?
    var favouriteId: Int?
}

struct CatRequest: Encodable {
    var imageId: String?
    var subId: String?
    
    private enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case subId = "sub_id"
    }
}
