//
//  FoodCollection.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation
import UIKit

struct FoodCollection: Codable {
    let title: String
    var venues: [Venue]
    let collectionImage: Data?
    let id: Int
    let venueImages: [Data?]
    
    static func getIDForNewCollection() -> Int {
           do {
            let collections = try FoodCollectionPersistenceHelper.manager.getCollections()
               let max = collections.map{$0.id}.max() ?? 0
               return max + 1
           } catch {
               print(error)
           }
          return 0
       }
    
    init(title: String, venue: [Venue], image: Data?, images: [Data?]) {
        self.title = title
        self.venues = venue
        self.collectionImage = image
        self.id = FoodCollection.getIDForNewCollection()
        self.venueImages = images
    }
}
