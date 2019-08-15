//
//  FavouriteModel.swift
//  CatApp
//
//  Created by Stuti on 04/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

struct FavouriteCats: Decodable, Equatable, ListType {
    var id: String?
    var url: URL?
    var favouriteId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case favouriteId = "id"
        case image
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        favouriteId = try? container.decode(Int.self, forKey: .favouriteId)
        let image = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .image)
        url = try? image.decode(URL.self, forKey: .url)
    }
}

struct MarkFavourite: Decodable {
    var favouriteId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case favouriteId = "id"
    }
}

struct UnmarkFavourite: Decodable {
    var message: String?
}
