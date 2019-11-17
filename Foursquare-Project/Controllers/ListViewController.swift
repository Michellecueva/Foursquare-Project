//
//  ListViewController.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/4/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var venues = [Venue]() {
        didSet {
            listTableView.reloadData()
        }
    }
    
    var idToImageMap = [String: UIImage]()
    var currentVenueImages: [Data?]?
    
    lazy var listTableView: UITableView = {
        let tableview = UITableView(frame: self.view.frame)
        tableview.register(SearchTableViewCell.self, forCellReuseIdentifier: "VenueCell")
        tableview.rowHeight = 80
        return tableview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Results"
        self.view.addSubview(listTableView)
        listTableView.delegate = self
        listTableView.dataSource = self
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! SearchTableViewCell
        
        let venue = venues[indexPath.row]
        
        // This is used for the collections view
        if let venueImages = currentVenueImages {
            if let venueImage = venueImages[indexPath.row] {
                    cell.venueImage.image = UIImage(data: venueImage)
            }
            
        }
        
        cell.nameLabel.text = venue.name
        
        // This is used for the results view
        if let image = idToImageMap[venue.id]  {
             cell.venueImage.image = image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DVC = DetailVC()
        DVC.venue = venues[indexPath.row]
        DVC.idToImageMap = idToImageMap
        self.navigationController?.pushViewController(DVC, animated: true)
    }
    
}
