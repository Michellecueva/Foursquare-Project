//
//  CollectionViewCell.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/4/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CellDelegate?
    
    var nameLabel: UILabel = {
          let label = UILabel()
          label.numberOfLines = 0
          label.adjustsFontSizeToFitWidth = true
          label.textAlignment = .center
          label.contentMode = .top
          label.font = .boldSystemFont(ofSize: 18)
          label.alpha = 1
          
          return label
      }()
    
    var foodImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var addButton: UIButton = { [unowned self] in
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
 
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          foodImage.layer.cornerRadius = 30
          self.contentView.addSubview(foodImage)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(addButton)
          configureConstraints()
          
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonPressed(sender: UIButton) {
        delegate?.addToCollection(tag: sender.tag)
    }

         private func configureConstraints() {
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
                foodImage.translatesAutoresizingMaskIntoConstraints = false
            addButton.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    
                    foodImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                    foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    foodImage.widthAnchor.constraint(equalToConstant: 200),
                    foodImage.heightAnchor.constraint(equalToConstant: 200),
                    
                    nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                    nameLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 50),
                    
                    addButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                    addButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    addButton.heightAnchor.constraint(equalToConstant: 200),
                    addButton.widthAnchor.constraint(equalToConstant: 200)
                    
       
                ])
            }
    
    //Mark: Properties
       
     
               private var collectionView: UICollectionView?
               private var index: Int?
    
    public func configureCollectionCell(with collection: FoodCollection, collectionView: UICollectionView, index: Int) {
          self.collectionView = collectionView
          self.index = index
        self.nameLabel.text = collection.title
        
        guard let dataImage = collection.image else {return}
        self.foodImage.image = UIImage(data: dataImage)
       
    
      }
    
    public func configureEditingCollectionCell(with collection: FoodCollection, collectionView: UICollectionView, index: Int) {
            self.collectionView = collectionView
            self.index = index
          self.nameLabel.text = collection.title
            self.addButton.isHidden = false
          
          guard let dataImage = collection.image else {return}
          self.foodImage.image = UIImage(data: dataImage)
        }
      

}
