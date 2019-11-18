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
          ])
      }
    
    private func errorAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          
          let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
          alert.addAction(cancel)
          present(alert,animated: true)
      }
    
    
      @objc func buttonPressed() {
        guard let fieldTitle = titleTextField.text else {
            errorAlert(title: "Missing Title", message: "You must enter a title to create a collection")
            return
        }
        
        let getCollection = try? FoodCollectionPersistenceHelper.manager.getCollections()
        
        let collectionWithSameTitle = getCollection?.filter{$0.title == fieldTitle}
        
        
        if collectionWithSameTitle?.count == 0 {
            
            let imageData = UIImage(named: "noImage")?.jpegData(compressionQuality: 1.0)
            
            let newCollection = FoodCollection(title: fieldTitle, venue: [], image: imageData, images: [] )
            
            try? FoodCollectionPersistenceHelper.manager.save(newCollection: newCollection)
            
            self.navigationController?.popViewController(animated: true)
        } else {
            errorAlert(title: "Already Exists", message: "You already have a collection with the same title")
        }
        
    }
    
}
