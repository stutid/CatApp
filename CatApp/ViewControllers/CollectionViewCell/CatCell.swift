//
//  CatCell.swift
//  CatApp
//
//  Created by Stuti on 01/08/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class CatCell: UICollectionViewCell {
    
    //MARK:- Outlets and Properties
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var btn: UIButton!
    private var listType: ListType?
    weak var favDelegate: FavouriteDelegate?
    
    //MARK:- Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
        contentView.roundCorners()
        imgView.roundCorners()
    }
    
    func set(barType: TabBarItem, and listType: ListType) {
        self.listType = listType
        imgView.downloadImage(from: listType.url)
        
        if barType == TabBarItem.allList {
            if listType.favouriteId != nil {
                btn.isSelected = true
                setIcon(true)
            } else {
                btn.isSelected = false
                setIcon(false)
            }
            btn.isUserInteractionEnabled = true
        } else {
            btn.isSelected = true
            setIcon(true)
            btn.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            setIcon(true)
            favDelegate?.mark(for: listType)
        } else {
            setIcon(false)
            favDelegate?.delete(for: listType)
        }
    }
    
    private func setIcon(_ isFav: Bool) {
        if isFav {
            btn.setImage(UIImage(named: "fav_icon"), for: .normal)
        } else {
            btn.setImage(UIImage(named: "unfav_icon"), for: .normal)
        }
    }
}
