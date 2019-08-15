//
//  Protocols.swift
//  CatApp
//
//  Created by Stuti on 04/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

protocol UIDelegate: class {
    func updateUI()
    func updateUI(atIndex index: Int)
    func show(message: String)
}

protocol FavouriteDelegate: class {
    func mark(for listType: ListType?)
    func delete(for listType: ListType?)
}

protocol ListType {
    var id: String? { get set }
    var url: URL? { get set }
    var favouriteId: Int? { get set }
}

