//
//  LocalDataSource.swift
//  Submission Restaurant
//
//  Created by Galfari on 14/12/21.
//

import Foundation
import RealmSwift
import Combine


protocol LocalDataSourceProtocol: class {
    func getFavoriteRestaurant() -> AnyPublisher<[RestaurantEntity], Error>
    func getRestaurants() -> AnyPublisher<[RestaurantEntity], Error>
    func addRestaurants(from categories: [RestaurantEntity]) -> AnyPublisher<Bool, Error>
    func updateFavoriteRes(by idMeal: String) -> AnyPublisher<RestaurantEntity, Error>
}

final class LocalDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = {
        realmDatabase in return LocalDataSource(realm: realmDatabase)
    }
    
}

extension LocalDataSource: LocalDataSourceProtocol {
    
    func getRestaurants() -> AnyPublisher<[RestaurantEntity], Error> {
        return Future<[RestaurantEntity], Error> { completion in
            if let realm = self.realm {
                let categories: Results<RestaurantEntity> = {
                    realm.objects(RestaurantEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(categories.toArray(ofType: RestaurantEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoriteRestaurant() -> AnyPublisher<[RestaurantEntity], Error> {
        return Future<[RestaurantEntity], Error> { completion in
            if let realm = self.realm {
                let restaurantEntities = {
                    realm.objects(RestaurantEntity.self)
                        .filter("favorite = \(true)")
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(restaurantEntities.toArray(ofType: RestaurantEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addRestaurants(
        from restaurant: [RestaurantEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for restaurant in restaurant {
                            realm.add(restaurant, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateFavoriteRes(
        by idRes: String
    ) -> AnyPublisher<RestaurantEntity, Error> {
        return Future<RestaurantEntity, Error> { completion in
            if let realm = self.realm, let restaurantEntity = {
                realm.objects(RestaurantEntity.self).filter("id = '\(idRes)'")
            }().first {
                do {
                    try realm.write {
                        restaurantEntity.setValue(!restaurantEntity.favorite, forKey: "favorite")
                    }
                    completion(.success(restaurantEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
