//
//  CollectionVC.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    var foodCollections = [FoodCollection]() {
        didSet {
            foodCollectionView.reloadData()
        }
    }
    
    lazy var foodCollectionView: UICollectionView = {
           let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
           layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
           layout.itemSize = CGSize(width: 200, height: 350)
           layout.scrollDirection = .vertical

           let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
           collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "foodCell")
           collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
           
           
           return collectionView
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "My Collection"
        self.navigationItem.setRightBarButton(.init(barButtonSystemItem: .add, target: self, action: #selector(pressedAddButton)), animated: true)
        self.view.addSubview(foodCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    @objc func pressedAddButton() {
        let createVC = CreateCollectionVC()
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    private func loadData() {
        do {
            foodCollections = try FoodCollectionPersistenceHelper.manager.getCollections()
        } catch {
            //figure out what you usually put here
        }
        
    }

}

extension CollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return foodCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.foodCollectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as? CollectionViewCell else {
            print("didnt find cell")
            return UICollectionViewCell()}
        
        let currentFoodCollection = foodCollections[indexPath.row]
        
        ///fix this optional
        cell.foodImage.image = UIImage(data: currentFoodCollection.image!)
        cell.nameLabel.text = currentFoodCollection.title
        return cell
    }
}
