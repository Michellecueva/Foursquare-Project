//
//  ListViewController.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/4/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var locations = [Location]() {
        didSet {
            listTableView.reloadData()
        }
    }
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
