//
//  CreateCollectionVC.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class CreateCollectionVC: UIViewController {
    
    lazy var titleTextField: UITextField = {
           let textField = UITextField()
           textField.backgroundColor = .lightText
           textField.borderStyle = .bezel
           textField.textAlignment = .center
           textField.placeholder = "Enter New Collection Title"
           return textField
       }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(titleTextField)
        self.view.addSubview(createButton)
        addTextFieldConstraints()
        addButtonConstraints()
    }
    
   private func addTextFieldConstraints() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            titleTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func addButtonConstraints() {
          createButton.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              createButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
              createButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50),
//              titleTextField.heightAnchor.constraint(equalToConstant: 50),
//              titleTextField.widthAnchor.constraint(equalToConstant: 300)
          ])
      }
    
    
      @objc func buttonPressed() {
        guard let title = titleTextField.text else {
            //print alert
            return
        }
        
        let imageData = UIImage(named: "noImage")?.jpegData(compressionQuality: 1.0)
        
        let newCollection = FoodCollection(title: title, venue: [], image: imageData )
        
        try? FoodCollectionPersistenceHelper.manager.save(newCollection: newCollection)
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
