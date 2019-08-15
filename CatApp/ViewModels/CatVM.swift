//
//  CatVM.swift
//  CatApp
//
//  Created by Stuti on 01/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

class CatVM {
    
    //MARK:- Properties
    private let catApiManager = CatApiManager.shared
    private var cats = [Cat]()
    private var favouriteCats = [FavouriteCats]()
    private var type: TabBarItem
    weak var uidelegate: UIDelegate?
    
    //MARK:- Methods
    init(_ type: TabBarItem) {
        self.type = type
        if type == .allList {
            fetchAllCats()
        } else {
            fetchAllFavouriteCats()
        }
    }
    
    func getType() -> TabBarItem {
        return type
    }
    
    func getCount() -> Int {
        if type == TabBarItem.allList {
            return cats.count
        }
        return favouriteCats.count
    }
    
    func getObject(at index: Int) -> ListType {
        if type == TabBarItem.allList {
            return cats[index]
        }
        return favouriteCats[index]
    }
    
    private func fetchAllCats() {
        catApiManager.fetchAllCats { [weak self] (catsArr, error) in
            guard let catsArr = catsArr else {
                self?.uidelegate?.show(message: Key.Error.message)
                return
            }
            self?.cats.removeAll()
            self?.cats.append(contentsOf: catsArr)
            self?.uidelegate?.updateUI()
        }
    }
    
    func createData(from listType: ListType?) {
        guard let id = listType?.id else { return }
        guard let listType = listType else { return }
        guard let index = cats.firstIndex(of: listType as! Cat) else { return }
        
        let request = CatRequest(imageId: id, subId: Key.SubId.title)
        let encodedData = try? JSONEncoder().encode(request)
        markFavourite(with: encodedData, at: index)
    }
    
    private func markFavourite(with encodedData: Data?, at index: Int) {
        catApiManager.markFavourite(with: encodedData) { [weak self] (markedFavourite, error) in
            guard let markedFavourite = markedFavourite else {
                self?.uidelegate?.show(message: Key.Error.message)
                return
            }
            self?.cats[index].favouriteId = markedFavourite.favouriteId
            self?.uidelegate?.updateUI(atIndex: index)
            self?.uidelegate?.show(message: Key.MarkedAsFav.message)
        }
    }
    
    func delete(for listType: ListType?) {
        guard let id = listType?.favouriteId else { return }
        guard let listType = listType else { return }
        guard let index = cats.firstIndex(of: listType as! Cat) else { return }
        
        catApiManager.unmarkFavourite(for: id) { [weak self] (isSuccessful, error) in
            guard let _ = isSuccessful else {
                self?.uidelegate?.show(message: Key.Error.message)
                return
            }
            self?.cats[index].favouriteId = nil
            self?.uidelegate?.updateUI(atIndex: index)
            self?.uidelegate?.show(message: Key.UnmarkedFromFav.message)
        }
    }
    
    func fetchAllFavouriteCats() {
        if type == .allList {
            return
        }
        catApiManager.fetchAllFavourites { [weak self] (favCatsArr, error) in
            guard let favCatsArr = favCatsArr else {
                self?.uidelegate?.show(message: Key.Error.message)
                return
            }
            self?.favouriteCats.removeAll()
            self?.favouriteCats.append(contentsOf: favCatsArr)
            self?.uidelegate?.updateUI()
        }
    }
}
