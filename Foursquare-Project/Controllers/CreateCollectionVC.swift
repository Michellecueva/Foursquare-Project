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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(titleTextField)
        addTextFieldConstraints()
    }
    
    func addTextFieldConstraints() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            titleTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
}
