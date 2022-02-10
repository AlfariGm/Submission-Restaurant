//
//  FavoriteRouter.swift
//  Submission Restaurant
//
//  Created by Galfari on 02/02/22.
//

import SwiftUI

class FavoriteRouter {

  func makeFavoriteView(for restaurant: RestaurantModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(restaurant: restaurant)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailHomeController(presenter: presenter)
  }
  
}
