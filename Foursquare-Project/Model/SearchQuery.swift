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

class Venue:  NSObject, Codable, MKAnnotation {
    
    private var position: String
    
    var coordinate: CLLocationCoordinate2D {
        let latLong = position.components(separatedBy: ",").map {$0.trimmingCharacters(in: .whitespacesAndNewlines)}.map{Double($0)}
        
        guard latLong.count == 2,
        
        let lat = latLong[0],
            let long = latLong[1] else {return CLLocationCoordinate2D.init()}
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var hasValidCoordinates: Bool {
        return coordinate.latitude != 0 && coordinate.longitude != 0
    }
    
    static func getQuery(from JSONData: Data) -> [Venue?] {
        var venues = [Venue?]()
        do {
            venues = try JSONDecoder().decode(SearchQueryWrapper.self, from: JSONData).response.groups[0].items.map({$0.venue})
        } catch {
            print("smd")
        }
        return venues
    }
    
    
}


