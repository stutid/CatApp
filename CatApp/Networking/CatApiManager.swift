//
//  CatApiManager.swift
//  CatApp
//
//  Created by Stuti on 06/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

class CatApiManager {
    static let shared = CatApiManager()
    private let apiManager = ApiManager.shared
    private init() { }
    
    //MARK:- Fetch all cats API
    func fetchAllCats(completionHandler: @escaping ([Cat]?, Error?) -> ()) {
        let url = URLConstants.getAllCats.url
        let request = apiManager.createRequest(url: url, method: .get)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else { return }
            do {
                let allCats = try JSONDecoder().decode([Cat].self, from: data)
                completionHandler(allCats, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    //MARK:- Fetch all favourite cats API
    func fetchAllFavourites(completionHandler: @escaping ([FavouriteCats]?, Error?) -> ()) {
        let url = URLConstants.getAllFavourites.url
        let request = apiManager.createRequest(url: url, method: .get)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else { return }
            do {
                let favCats = try JSONDecoder().decode([FavouriteCats].self, from: data)
                completionHandler(favCats, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    //MARK:- Mark a cat as favourite API
    func markFavourite(with data: Data?, completionHandler: @escaping (MarkFavourite?, Error?) -> ()) {
        let url = URLConstants.markFavourite.url
        let request = apiManager.createRequest(url: url, method: .post, data: data)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else { return }
            do {
                let markedFavourite = try JSONDecoder().decode(MarkFavourite.self, from: data)
                completionHandler(markedFavourite, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
    }
    
    //MARK:- Unmark a cat from favourites API
    func unmarkFavourite(for id: Int, completionHandler: @escaping (Bool?, Error?) -> ()) {
        let url = URLConstants.deleteFavourite(id).url
        let request = apiManager.createRequest(url: url, method: .delete)
        apiManager.fetch(request: request) { (data, error) in
            guard let data = data else { return }
            do {
                let unmarkedFavourite = try JSONDecoder().decode(UnmarkFavourite.self, from: data)
                if unmarkedFavourite.message == "SUCCESS" {
                    completionHandler(true, nil)
                } else {
                    completionHandler(false, error)
                }
            } catch {
                completionHandler(false, error)
            }
        }
    }
}
