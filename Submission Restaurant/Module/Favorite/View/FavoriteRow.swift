//
//  FavoriteRow.swift
//  Submission Restaurant
//
//  Created by Galfari on 02/02/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {

  var restaurant: RestaurantModel

  var body: some View {
    VStack {
      HStack(alignment: .top) {
        imageCategory
        content
        Spacer()
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 8)

      Divider()
        .padding(.leading)
    }
  }

}

extension FavoriteRow {

  var imageCategory: some View {
    WebImage(url: URL(string: "https://restaurant-api.dicoding.dev/images/large/"+restaurant.pictureId))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 120)
      .cornerRadius(20)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(restaurant.name)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
        .lineLimit(3)

      Text(String(restaurant.rating))
        .font(.system(size: 16))
        .lineLimit(2)

    }.padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 16,
        trailing: 16
      )
    )
  }

}
