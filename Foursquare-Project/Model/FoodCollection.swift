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
    let venue: [Venue]
    let image: Data?
}
