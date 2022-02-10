//
//  RestaurantResponse.swift
//  Submission Restaurant
//
//  Created by Galfari on 14/12/21.
//

import Foundation

struct RestaurantsResponse: Decodable {
    
    let restaurants: [RestaurantResponse]
}

struct RestaurantResponse: Decodable {
    
    let idRestaurant: String
    let name: String
    let description: String
    let pictureId: String
    let rating: Double
    
    private enum CodingKeys: String, CodingKey {
        case idRestaurant = "id"
        case name = "name"
        case description = "description"
        case pictureId = "pictureId"
        case rating = "rating"
    }
}
