//
//  VenuePhoto.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/16/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

enum PhotoError: Error {
    case photoInfoNotFound
}


struct VenuePhotoWrapper: Codable {
    let response: ResponseWrapper
    
    static func decodePhotoInfoFromData(from jsonData: Data) throws -> (String,String) {
        let response = try JSONDecoder().decode(VenuePhotoWrapper.self, from: jsonData)
        if response.response.photos.items.count == 0 {
            throw PhotoError.photoInfoNotFound
        }
        let photoInfo = response.response.photos.items[0]
        return (photoInfo.prefix, photoInfo.suffix)
      }
}

struct ResponseWrapper: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let items: [Item]
}

struct Item: Codable {
    let prefix: String
    let suffix: String
}
