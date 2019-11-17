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
    
    func deleteCollection(withID: Int) throws {
        do {
            let collections = try getCollections()
            let newCollection = collections.filter { $0.id != withID}
            try persistenceHelper.replace(elements: newCollection)
        }
    }
    
    func replaceCollection(withOldCollectionID: Int, newCollection: FoodCollection) throws {
       do {
           let collections = try getCollections()
        guard let indexOfOldCollection = collections.firstIndex(where: {$0.id == withOldCollectionID}) else {return}
        try persistenceHelper.saveAtSpecificIndex(newElement: newCollection, index: indexOfOldCollection)
        try deleteCollection(withID: withOldCollectionID)
       }
   }
    
    
    private let persistenceHelper = PersistenceHelper<FoodCollection>(fileName: "foodCollection.plist")
    
    private init() {}
}
