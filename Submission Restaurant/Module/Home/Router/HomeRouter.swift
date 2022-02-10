//
//  HomeRouter.swift
//  Submission Restaurant
//
//  Created by Galfari on 14/12/21.
//

import SwiftUI


class HomeRouter {
    
    func makeDetailView(for restaurant: RestaurantModel) -> some View {
      let detailUseCase = Injection.init().provideDetail(restaurant: restaurant)
      let presenter = DetailPresenter(detailUseCase: detailUseCase)
      return DetailHomeController(presenter: presenter)
    }
}
