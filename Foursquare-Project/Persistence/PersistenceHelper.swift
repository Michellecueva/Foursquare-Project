//
//  PersistenceHelper.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable> {
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func save(newElement: T) throws {
         var elements = try getObjects()
            elements.insert(newElement, at: 0)
        try replace(elements: elements)
    }
    
    func replace(elements: [T]) throws {
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func saveAtSpecificIndex(newElement: T, index: Int) throws {
           var elements = try getObjects()
           elements.insert(newElement, at: index)
           try replace(elements: elements)
           
    }
    
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    private func filePathFromDocumentsDirectory(name: String) -> URL {
        return documentsDirectory.appendingPathComponent(name)
    }
    
    private let fileName: String
    
    private var url: URL {
        return filePathFromDocumentsDirectory(name: fileName)
    }
}
