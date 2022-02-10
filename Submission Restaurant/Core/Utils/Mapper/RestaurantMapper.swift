//
//  RestaurantMapper.swift
//  Submission Restaurant
//
//  Created by Galfari on 15/12/21.
//

final class RestautantMapper {
    
    static func mapRestauranResponseToEntities(
        input restauranResponses: [RestaurantResponse]
    ) -> [RestaurantEntity] {
        return restauranResponses.map { result in
            let newRestaurant = RestaurantEntity()
            newRestaurant.id = result.idRestaurant
            newRestaurant.name = result.name
            newRestaurant.desc = result.description
            newRestaurant.pictureId = result.pictureId
            newRestaurant.rating = result.rating
            return newRestaurant
        }
    }
    
    static func mapRestaurantEntitiesToDomains(
        input restaurantEntitie: [RestaurantEntity]
    ) -> [RestaurantModel] {
        return restaurantEntitie.map { result in
            return RestaurantModel(
                id: result.id,
                name: result.name,
                description: result.desc,
                pictureId: result.pictureId,
                rating: result.rating,
                favorite: result.favorite
            )
        }
    }
    
    static func mapDetailResEntityToDomain(
      input resEntity: RestaurantEntity
    ) -> RestaurantModel {
      return RestaurantModel(
        id: resEntity.id ,
        name: resEntity.name,
        description: resEntity.desc,
        pictureId: resEntity.pictureId,
        rating: resEntity.rating,
        favorite: resEntity.favorite
      )
    }
}
