//
//  FavoriteInteractor.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/01/22.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getFavoriteRestaurant() -> AnyPublisher<[RestaurantModel], Error>
}


class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: RestaurantRepositoryProtocol
    
    required init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteRestaurant() -> AnyPublisher<[RestaurantModel], Error> {
      return repository.getFavoriteRestaurant()
    }
    
}
