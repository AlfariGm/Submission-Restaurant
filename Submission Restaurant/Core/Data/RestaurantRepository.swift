//
//  RestaurantRepository.swift
//  Submission Restaurant
//
//  Created by Galfari on 14/12/21.
//

import Foundation
import Combine

protocol RestaurantRepositoryProtocol {
    func getRestaurant() -> AnyPublisher<[RestaurantModel], Error>
    func getFavoriteRestaurant() -> AnyPublisher<[RestaurantModel], Error>
    func updateFavoriteRes(by idMeal: String) -> AnyPublisher<RestaurantModel, Error>
}

final class RestaurantRepository: NSObject {
    
    typealias RestaurantInstance = (LocalDataSource, RemoteDataSource) -> RestaurantRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocalDataSource
    
    private init(locale: LocalDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: RestaurantInstance = { localeRepo, remoteRepo in
        return RestaurantRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension RestaurantRepository: RestaurantRepositoryProtocol {
    
    func getRestaurant() -> AnyPublisher<[RestaurantModel], Error> {
        return self.locale.getRestaurants()
            .flatMap { result -> AnyPublisher<[RestaurantModel], Error> in
                if result.isEmpty {
                    return self.remote.getRestaurants()
                        .map { RestautantMapper.mapRestauranResponseToEntities(input: $0) }
                        .catch { _ in self.locale.getRestaurants() }
                        .flatMap { self.locale.addRestaurants(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getRestaurants()
                            .map { RestautantMapper.mapRestaurantEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getRestaurants()
                        .map { RestautantMapper.mapRestaurantEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getFavoriteRestaurant() -> AnyPublisher<[RestaurantModel], Error> {
        return self.locale.getFavoriteRestaurant()
            .map { RestautantMapper.mapRestaurantEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func updateFavoriteRes(
        by idMeal: String
    ) -> AnyPublisher<RestaurantModel, Error> {
        return self.locale.updateFavoriteRes(by: idMeal)
            .map { RestautantMapper.mapDetailResEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
   
}
