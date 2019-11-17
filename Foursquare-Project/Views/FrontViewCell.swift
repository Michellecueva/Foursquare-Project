//
//  FrontViewCell.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class FrontViewCell: UICollectionViewCell {
    var foodImage: UIImageView = {
          let image = UIImageView()
          return image
      }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
          foodImage.layer.cornerRadius = 30
          self.contentView.addSubview(foodImage)
          configureConstraints()
          
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
                   foodImage.translatesAutoresizingMaskIntoConstraints = false
                   
                   NSLayoutConstraint.activate([
                       
                       foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                       foodImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                       foodImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                       foodImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
                       
                   ])
               }

}
