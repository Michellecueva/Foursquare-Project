//
//  CollectionViewCell.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/4/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
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
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          foodImage.layer.cornerRadius = 30
          self.contentView.addSubview(foodImage)
        self.contentView.addSubview(nameLabel)
          configureConstraints()
          
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

         private func configureConstraints() {
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
                foodImage.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    
    
                    
                    foodImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                    foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    foodImage.widthAnchor.constraint(equalToConstant: 200),
                    foodImage.heightAnchor.constraint(equalToConstant: 200),
                    
                    nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                                       nameLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 50)
       
                ])
            }

}
