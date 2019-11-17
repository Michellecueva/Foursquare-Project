//
//  ViewController.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/3/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SearchVC: UIViewController {
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    let searchRadius: CLLocationDistance = 2000
    var userLocation = "New York, NY" {
        didSet {
            locationSearchBar.placeholder = userLocation
        }
    }
    
    var userVenue = ""
    
    var idToImageMap: [String: UIImage] = [:]
    
    
      lazy var frontCollectionView:UICollectionView = {
          var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
          let colletionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout )
          layout.scrollDirection = .horizontal
          layout.itemSize = CGSize(width: 125, height: 125)
        colletionView.register(FrontViewCell.self, forCellWithReuseIdentifier: "frontCell")
          colletionView.dataSource = self
        colletionView.backgroundColor = .clear
          return colletionView
      }()

    private var venues = [Venue]() {
        didSet {
            let annotations = self.mapView.annotations
            self.mapView.removeAnnotations(annotations)
            let locations = venues.map{$0.location}
            mapView.addAnnotations(locations.filter{ $0.hasValidCoordinates})
            
            for venue in venues {
                PhotoAPIClient.manager.getPhotoData(venueId: venue.id) { (result) in
                    switch result {
                    case .success((let prefix,let suffix)):
                        ImageHelper.shared.getImage(prefix: prefix, suffix: suffix) { (result) in
                            switch result {
                            case .success(let imageFromOnline):
                                self.idToImageMap[venue.id] = imageFromOnline
                            case .failure(let error):
                                print(error)
                            }
                        }
                    case .failure(let error):
                        print(error)
                        self.idToImageMap[venue.id] = UIImage(named: "noImage")
                    }
                }
            }
            
            frontCollectionView.reloadData()
            
        }
    }
    
    lazy var venueSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Venue"
        searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return searchBar
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        //        searchBar.placeholder = "New York, NY"
        searchBar.setImage(UIImage(systemName: "mappin"), for: .search, state: .normal)
        searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return searchBar
    }()
    
    lazy var listButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.addTarget(self, action: #selector(pressedListButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Search"
        addSubviews()
        addConstraints()
        locationManager.delegate = self
        locationSearchBar.delegate = self
        venueSearchBar.delegate = self
        requestLocationAndAuthorizeIfNeeded()
    }
    
    func loadData(lat: Double, long: Double, venue: String) {
        QueryAPIClient.manager.getQueryData(lat: lat, long: long, venue: venue) { (result) in
            switch result {
            case .success(let infoFromOnline):
                self.venues = infoFromOnline
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func pressedListButton() {
        let listVC = ListViewController()
        listVC.venues = venues
        listVC.idToImageMap = idToImageMap
        self.navigationController?.pushViewController(listVC, animated: true)
    }
    
    private func addSubviews() {
        self.view.addSubview(venueSearchBar)
        self.view.addSubview(locationSearchBar)
        self.view.addSubview(listButton)
        self.view.addSubview(mapView)
        self.view.addSubview(frontCollectionView)
    }
    
    private func addConstraints() {
        addVenueSearchBarConstraints()
        addLocationSearchBarConstraints()
        addListButtonConstraints()
        addMapViewConstraints()
        foodCollectionViewConstraints()
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
    
    private func addMapViewConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: locationSearchBar.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private  func foodCollectionViewConstraints() {
             frontCollectionView.translatesAutoresizingMaskIntoConstraints = false
        frontCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        frontCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
             frontCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        frontCollectionView.heightAnchor.constraint(equalToConstant: 125).isActive = true
         }
    
    private func requestLocationAndAuthorizeIfNeeded() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func getCoordinatesAndVenue(location: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            guard error == nil else {
                print("error found")
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("no placemark")
                return
            }
            
            guard let newLocation = placemark.location else {
                print("no location found")
                return
            }
            
            print(newLocation)
            
            
            self.mapView.setCenter(CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude), animated: true)
            
            self.loadData(lat: newLocation.coordinate.latitude , long: newLocation.coordinate.longitude, venue: self.userVenue)
        }
        
    }
}

extension SearchVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New locations \(locations)")
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(locations[0]) { (placemarks, error) in
            
            guard let existingPlacemarks = placemarks else {
                print(error as Any)
                return
            }
            for placemark in existingPlacemarks {
                let city = placemark.locality
                let state = placemark.administrativeArea
                
                guard let userCity = city, let userState = state else {return}
                
                self.userLocation = "\(userCity), \(userState)"
            }
        }
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occurred: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            
        default:
            break
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("return")
        
        if searchBar == locationSearchBar {
            
            guard let location = searchBar.text else {return}
            userLocation = location
            getCoordinatesAndVenue(location: userLocation)
            
        } else {
            
            guard let venue = searchBar.text else {return}
            userVenue = venue
            getCoordinatesAndVenue(location: userLocation)
        }
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.frontCollectionView.dequeueReusableCell(withReuseIdentifier: "frontCell", for: indexPath) as? FrontViewCell else {
            print("didnt find cell")
            return UICollectionViewCell()}
        
        let currentVenue = venues[indexPath.row]
        
          if let image = idToImageMap[currentVenue.id]  {
            cell.foodImage.image = image
          } else {
            cell.foodImage.image = UIImage(named: "noImage")
        }
        
        return cell
    }
}
