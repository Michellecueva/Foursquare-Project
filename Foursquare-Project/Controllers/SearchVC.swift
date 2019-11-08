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
    var userLocation = String() {
        didSet {
            locationSearchBar.placeholder = userLocation
        }
    }
    
    private var locations = [Location]() {
        didSet {
            mapView.addAnnotations(locations.filter{ $0.hasValidCoordinates})
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
           searchBar.placeholder = "New York, NY"
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
        locationManager.delegate = self
        locationSearchBar.delegate = self
        requestLocationAndAuthorizeIfNeeded()
        loadData(lat: (locationManager.location?.coordinate.latitude) ?? 40.7831, long: (locationManager.location?.coordinate.longitude) ?? -73.9712)
    }
    
    func loadData(lat: Double, long: Double) {
        QueryAPIClient.manager.getQueryData(lat: lat, long: long) { (result) in
            switch result {
            case .success(let infoFromOnline):
                self.locations = infoFromOnline 
            case .failure(let error):
                print(error)
            }
        }
      }
    
    private func addSubviews() {
        self.view.addSubview(venueSearchBar)
        self.view.addSubview(locationSearchBar)
        self.view.addSubview(listButton)
        self.view.addSubview(mapView)
    }
    
    private func addConstraints() {
        addVenueSearchBarConstraints()
        addLocationSearchBarConstraints()
        addListButtonConstraints()
        addMapViewConstraints()
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
    
    private func requestLocationAndAuthorizeIfNeeded() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
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
        
        userLocation = searchBar.text!
       let geocoder = CLGeocoder()
        
        guard let location = searchBar.text else {return}
        
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
            
            self.loadData(lat: newLocation.coordinate.latitude , long: newLocation.coordinate.longitude)
        }
    }
}

