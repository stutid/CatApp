//
//  CatVC.swift
//  CatApp
//
//  Created by Stuti on 01/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CatVC: UIViewController {

    //MARK:- Outlets and Properties
    @IBOutlet weak var collectionView: UICollectionView!
    var catVM: CatVM!
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        catVM.uidelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        catVM.fetchAllFavouriteCats()
    }
}

//MARK:- UICollectionView Data Source and Delegate
extension CatVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catVM.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CatCell.self)  , for: indexPath) as? CatCell else { return UICollectionViewCell() }
        cell.favDelegate = self
        let catListType = catVM.getObject(at: indexPath.row)
        cell.set(barType: catVM.getType(), and: catListType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = (collectionView.frame.size.width / 2) - 10
        return CGSize(width: newWidth, height: newWidth)
    }
}

//MARK:- Custom UI Delegate
extension CatVC: UIDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func updateUI(atIndex index: Int) {
        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    
    func show(message: String) {
        DispatchQueue.main.async {
            self.showAlert(with: message)
        }
    }
}

//MARK:- Custom Favourite Delegate
extension CatVC: FavouriteDelegate {
    func mark(for listType: ListType?) {
        catVM.createData(from: listType)
    }
    
    func delete(for listType: ListType?) {
        catVM.delete(for: listType)
    }
}
