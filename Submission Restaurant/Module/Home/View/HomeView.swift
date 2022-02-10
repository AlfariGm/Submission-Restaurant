//
//  HomeView.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/11/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ZStack {
          if presenter.loadingState {
            VStack {
              Text("Loading...")
              ActivityIndicator()
            }
          } else {
            ScrollView(.vertical, showsIndicators: false) {
              ForEach(
                self.presenter.restaurants,
                id: \.id
              ) { restaurant in
                ZStack {
                  self.presenter.linkBuilder(for: restaurant) {
                    RestaurantRow(restaurant: restaurant)
                  }.buttonStyle(PlainButtonStyle())
                }.padding(8)
              }
            }
          }
        }.onAppear {
          if self.presenter.restaurants.count == 0 {
            self.presenter.getRestaurant()
          }
        }.navigationBarTitle(
          Text("Restaurant Apps"),
          displayMode: .automatic
        )
    }
}

