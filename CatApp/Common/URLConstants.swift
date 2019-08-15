//
//  URLConstants.swift
//  CatApp
//
//  Created by Stuti on 01/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

enum URLConstants {
    private static let BASE_URL = "https://api.thecatapi.com/v1/"
    case getAllCats, markFavourite, deleteFavourite(Int), getAllFavourites
    
    var url: URL? {
        return URL(string: "\(URLConstants.BASE_URL)\(endPoint)")
    }
    
    private var endPoint: String {
        switch self {
        case .getAllCats:
            return "images/search?limit=20"
        case .markFavourite:
            return "favourites"
        case .deleteFavourite(let id):
            return "favourites/\(id)"
        case .getAllFavourites:
            return "favourites?sub_id=\(Key.SubId.title)"
        }
    }
}

enum HTTPMethod {
    case get, post, delete
    
    var type: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
