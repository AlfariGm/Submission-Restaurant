//
//  DetailInteractor.swift
//  Submission Restaurant
//
//  Created by Galfari on 10/01/22.
//

import Foundation
import Combine

protocol DetailUseCase {
    
    func getRestaurant() -> RestaurantModel
    func updateFavoriteRes() -> AnyPublisher<RestaurantModel, Error>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: RestaurantRepositoryProtocol
    private let restaurant: RestaurantModel
    
    required init(
        repository: RestaurantRepositoryProtocol,
        restaurant: RestaurantModel
    ) {
        self.repository = repository
        self.restaurant = restaurant
    }
    
    func getRestaurant() -> RestaurantModel {
        return restaurant
    }
    
    func updateFavoriteRes() -> AnyPublisher<RestaurantModel, Error> {
      return repository.updateFavoriteRes(by: restaurant.id)
    }
}
