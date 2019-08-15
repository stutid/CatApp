//
//  TabBarVC.swift
//  CatApp
//
//  Created by Stuti on 6/8/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class FirstTabBarVC: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let allCats = segue.destination  as? CatVC {
            allCats.catVM = CatVM(.allList)
        }
    }
}

class SecondTabBarVC: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favCats = segue.destination as? CatVC {
            favCats.catVM = CatVM(.favourite)
        }
    }
}
