//
//  FavoritePresenter.swift
//  Submission Restaurant
//
//  Created by Galfari on 02/02/22.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var restaurantModel: [RestaurantModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoriteRestaurant() {
        isLoading = true
        favoriteUseCase.getFavoriteRestaurant()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { restaurant in
                self.restaurantModel = restaurant
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for restaurant: RestaurantModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeFavoriteView(for: restaurant)) { content() }
    }
    
}
