//
//  DetailPresenter.swift
//  Submission Restaurant
//
//  Created by Galfari on 10/01/22.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    
    @Published var restaurant: RestaurantModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        restaurant = detailUseCase.getRestaurant()
    }
    
    func updateFavoriteMeal() {
        detailUseCase.updateFavoriteRes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { restaurant in
                self.restaurant = restaurant
            })
            .store(in: &cancellables)
    }
}
