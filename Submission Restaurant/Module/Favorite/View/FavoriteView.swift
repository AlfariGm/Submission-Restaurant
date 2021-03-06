//
//  FavoriteController.swift
//  Submission Restaurant
//
//  Created by Galfari on 22/12/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.restaurantModel.count == 0 {
                emptyFavorites
            } else {
                content
            }
        }.onAppear {
            self.presenter.getFavoriteRestaurant()
        }.navigationBarTitle(
            Text("Favorite Restaurant"),
            displayMode: .automatic
        )
    }
}

extension FavoriteView {
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyFavorites: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "Your favorite is empty"
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            ForEach(
                self.presenter.restaurantModel,
                id: \.id
            ) { restaurant in
                ZStack {
                    self.presenter.linkBuilder(for: restaurant) {
                        FavoriteRow(restaurant: restaurant)
                    }.buttonStyle(PlainButtonStyle())
                }
                
            }
        }
    }
}
