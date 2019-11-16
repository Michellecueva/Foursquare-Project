//
//  CollectionVC.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "My Collection"
        self.navigationItem.setRightBarButton(.init(barButtonSystemItem: .add, target: self, action: #selector(pressedAddButton)), animated: true)

    }
    
    @objc func pressedAddButton() {
        let createVC = CreateCollectionVC()
        self.navigationController?.pushViewController(createVC, animated: true)
    }

}

