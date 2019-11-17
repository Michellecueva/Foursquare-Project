//
//  DetailVC.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var venue: Venue!
    
    var idToImageMap: [String: UIImage] = [:]
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var foodImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setNavigationBar()
        addViews()
        addConstraints()
        addVenue()
    }
    
    @objc func addButtonPressed() {
           let collectionVC = CollectionVC()
        collectionVC.isAddingToMadeCollection = true
        self.navigationController?.pushViewController(collectionVC, animated: true)
        
       }
    
    private func setNavigationBar() {
        self.navigationItem.setRightBarButton(.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed)), animated: true)
    }
    
    private func addVenue() {
        nameLabel.text = venue.name
        foodImage.image = idToImageMap[venue.id]
    }
    
    private func addViews() {
        self.view.addSubview(nameLabel)
        self.view.addSubview(foodImage)
    }
    
    private func addConstraints() {
        addNameLabelConstraints()
        addFoodImageConstraints()
    }
    
    private func addNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
   
    private func addFoodImageConstraints() {
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            foodImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            foodImage.heightAnchor.constraint(equalToConstant: 500),
            foodImage.widthAnchor.constraint(equalToConstant: 400)
        ])
      }

}
