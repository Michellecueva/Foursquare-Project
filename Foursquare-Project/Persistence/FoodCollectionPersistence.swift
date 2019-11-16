//
//  FoodCollectionPersistence.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct FoodCollectionPersistenceHelper {
    static let manager = FoodCollectionPersistenceHelper()
    
    func save(newCollection: FoodCollection) throws {
        try persistenceHelper.save(newElement: newCollection)
    }
    
    func getCollections() throws -> [FoodCollection] {
        return try persistenceHelper.getObjects()
    }
    
//    func deletePhoto(title: String) throws {
//        do {
//            let cards = try getCards()
//            let newCards = cards.filter { $0.cardTitle != title}
//            try persistenceHelper.replace(elements: newCards)
//        }
//    }
    
    
    private let persistenceHelper = PersistenceHelper<FoodCollection>(fileName: "foodCollection.plist")
    
    private init() {}
}
