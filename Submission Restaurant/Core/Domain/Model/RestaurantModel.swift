//
//  RestaurantModel.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/11/21.
//

import Foundation

struct RestaurantModel: Equatable, Identifiable {
    
    let id: String
    let name: String
    let description: String
    let pictureId: String
    let rating: Double
    var favorite: Bool
}
