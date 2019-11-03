//
//  ViewController.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    lazy var venueSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Venue"
        searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return searchBar
    }()
    
    lazy var locationSearchBar: UISearchBar = {
           let searchBar = UISearchBar()
           searchBar.placeholder = "Location"
           searchBar.setImage(UIImage(systemName: "mappin"), for: .search, state: .normal)
           searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           return searchBar
       }()
    
    lazy var listButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        self.view.addSubview(venueSearchBar)
        self.view.addSubview(locationSearchBar)
        self.view.addSubview(listButton)
    }
    
    private func addConstraints() {
        addVenueSearchBarConstraints()
        addLocationSearchBarConstraints()
        addListButtonConstraints()
    }
    
    private func addVenueSearchBarConstraints() {
        venueSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            venueSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            venueSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            venueSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        ])

    }
    
    private func addLocationSearchBarConstraints() {
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationSearchBar.topAnchor.constraint(equalTo: venueSearchBar.bottomAnchor),
            locationSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            locationSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func addListButtonConstraints() {
        listButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            listButton.leadingAnchor.constraint(equalTo: venueSearchBar.trailingAnchor),
            listButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            listButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }


}

