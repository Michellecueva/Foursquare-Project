//
//  CollectionVC.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    var isAddingToMadeCollection = false
    
    var venueBeingAdded: Venue!
    
    var venueImageBeingAdded: UIImage!
    
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
           collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "foodCell")
           collectionView.showsVerticalScrollIndicator = false
           collectionView.backgroundColor = .clear
           
           
           return collectionView
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationBar()
        self.view.addSubview(foodCollectionView)
        foodCollectionView.dataSource = self
        foodCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    @objc func pressedAddButton() {
        let createVC = CreateCollectionVC()
        self.navigationController?.pushViewController(createVC, animated: true)
    }
    
    private func setNavigationBar() {
        self.navigationItem.title = "My Collection"
        
        if !isAddingToMadeCollection {
            self.navigationItem.setRightBarButton(.init(barButtonSystemItem: .add, target: self, action: #selector(pressedAddButton)), animated: true)
        }
    
    }
    
    private func loadData() {
        foodCollections = try! FoodCollectionPersistenceHelper.manager.getCollections()
    }
    
    private func addedVenueAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .default, handler: {
            (alert) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okay)
        alert.addAction(cancel)
        present(alert,animated: true)
    }

}

extension CollectionVC: UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return foodCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.foodCollectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as? CollectionViewCell else {
            print("didnt find cell")
            return UICollectionViewCell()}
        
        let currentFoodCollection = foodCollections[indexPath.row]
        
        cell.addButton.tag = indexPath.row
        if isAddingToMadeCollection {
            cell.configureEditingCollectionCell(with: currentFoodCollection, collectionView: foodCollectionView, index: indexPath.row)
        } else {
            cell.configureCollectionCell(with: currentFoodCollection, collectionView: foodCollectionView, index: indexPath.row)
        }
        
        cell.delegate = self

        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ListVC = ListViewController()
        
        ListVC.venues = foodCollections[indexPath.row].venues
        
        ListVC.currentVenueImages = foodCollections[indexPath.row].venueImages
        
        
        
        self.navigationController?.pushViewController(ListVC, animated: true)
        }
}

extension CollectionVC: CellDelegate {
    func addToCollection(tag: Int) {
        
        let currentCollection = foodCollections[tag]
        var currentCollectionImages = currentCollection.venueImages
        
        var currentVenueArr = currentCollection.venues
        currentVenueArr.append(venueBeingAdded)
        currentCollectionImages.append(venueImageBeingAdded.jpegData(compressionQuality: 1.0))
        
        let newCollection = FoodCollection(
            title: currentCollection.title,
            venue: currentVenueArr,
            image: currentCollectionImages[0],
            images: currentCollectionImages
        )
        
        try? FoodCollectionPersistenceHelper.manager.replaceCollection(withOldCollectionID: currentCollection.id, newCollection: newCollection)
        
        addedVenueAlert(title: "Saved!", message: "Your venue has been saved to \(newCollection.title)")
    }
    
}
