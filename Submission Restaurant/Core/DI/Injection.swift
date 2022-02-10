//
//  Injection.swift
//  Submission Restaurant
//
//  Created by Galfari on 14/12/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> RestaurantRepositoryProtocol {
        let realm = try? Realm()
        let locale: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        return RestaurantRepository.sharedInstance(locale, remote)
    }
    
    func proviceHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }

    func provideDetail(restaurant: RestaurantModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, restaurant: restaurant)
    }
    
    func provideFavRestaurant() -> FavoriteUseCase {
      let repository = provideRepository()
      return FavoriteInteractor(repository: repository)
    }
    
}
