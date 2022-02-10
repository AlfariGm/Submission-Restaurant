//
//  DetailHomeController.swift
//  Submission Restaurant
//
//  Created by Galfari on 22/12/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct DetailHomeController: View {
    
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                loadingIndicator
            } else {
                    ScrollView(.vertical) {
                        VStack {
                            imageRestaurant
                            spacer
                            menuButtonRes
                            spacer
                            content
                            spacer
                        }.padding()
                    }
            }
        }.navigationBarTitle(Text(self.presenter.restaurant.name), displayMode: .large)
    }
}

extension DetailHomeController {
    var spacer: some View {
        Spacer()
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var imageRestaurant: some View {
        WebImage(url: URL(string:
                            "https://restaurant-api.dicoding.dev/images/large/" + self.presenter.restaurant.pictureId))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 250.0, height: 250.0, alignment: .center)
    }
    
    var menuButtonRes: some View {
        HStack(alignment: .center) {
            Spacer()
            Text(self.presenter.restaurant.name)
                .font(.system(size: 15))
            Spacer()
            if presenter.restaurant.favorite {
                CustomIcon(
                    imageName: "heart.fill",
                    title: "Favorited"
                ).onTapGesture {
                    self.presenter.updateFavoriteMeal()
                }
            } else {
                CustomIcon(
                    imageName: "heart",
                    title: "Favorite"
                ).onTapGesture {
                    self.presenter.updateFavoriteMeal()
                }
            }
            Spacer()
        }.padding()
    }
    
    var description: some View {
        Text(self.presenter.restaurant.description)
            .font(.system(size: 15))
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle("Description")
                .padding([.top, .bottom])
            description
        }
    }
}
