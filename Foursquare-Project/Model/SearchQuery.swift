//
//  Foursquare.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/5/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct SearchQueryWrapper: Codable {
    let response: Response
}

struct Response: Codable {
    let groups: [Group]
}

struct Group: Codable {
    let items: [GroupItem]
}

struct GroupItem: Codable {
    let venue: Venue?
}

struct Venue: Codable{
    let location: Location
}

class Location:  NSObject, Codable, MKAnnotation {
    
    let lat: Double
    
    let lng: Double
    
    
    var coordinate: CLLocationCoordinate2D {
     
        
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
    var hasValidCoordinates: Bool {
        return coordinate.latitude != 0 && coordinate.longitude != 0
    }
    
    static func getQuery(from JSONData: Data) -> [Location] {
        var locations = [Location]()
        do {
            let optionalLocations = try JSONDecoder().decode(SearchQueryWrapper.self, from: JSONData).response.groups[0].items.map{$0.venue?.location}
            
            
            for element in optionalLocations  {
                if let nonOptional = element {
                    locations.append(nonOptional)
                }
            }
            
        } catch {
            print(error)
                
                //loop through each item
                //for each item we want to grab the venue
                // for every venue collection location
        }
        return locations
    }
    
    
}


