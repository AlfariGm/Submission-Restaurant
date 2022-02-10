//
//  HomeInteractor.swift
//  Submission Restaurant
//
//  Created by Galfari on 07/01/22.
//

import Foundation
import Combine


protocol HomeUseCase {
        
    func getRestaurants() -> AnyPublisher<[RestaurantModel], Error>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: RestaurantRepositoryProtocol
    
    required init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    
    func getRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
      return repository.getRestaurant()
    }
}
