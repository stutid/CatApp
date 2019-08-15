//
//  Constants.swift
//  CatApp
//
//  Created by Stuti on 01/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

enum Key {
    case SubId, Error, OK, MarkedAsFav, UnmarkedFromFav
    
    var title: String {
        switch self {
        case .SubId:
            return "stuti99"
        case .OK:
            return "OK"
        default:
            return ""
        }
    }
    
    var message: String {
        switch self {
        case .Error:
            return "There was an error"
        case .MarkedAsFav:
            return "Marked as Favourite"
        case .UnmarkedFromFav:
            return "Unmarked from Favourites"
        default:
            return ""
        }
    }
}

enum TabBarItem: Int {
    case allList
    case favourite
}
