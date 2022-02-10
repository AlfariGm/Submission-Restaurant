//
//  RestaurantRow.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct  RestaurantRow: View {
    
    var restaurant: RestaurantModel
    
    var body: some View {
        VStack {
            imagesRestaurant
            content
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 250 )
        .cornerRadius(30)
    }
}

extension RestaurantRow {
    
    var imagesRestaurant: some View {
        WebImage(url: URL(string: "https://restaurant-api.dicoding.dev/images/large/"+restaurant.pictureId))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .frame(width: 200)
            .cornerRadius(30)
            .padding(.top)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(restaurant.name)
                .font(.title)
                .bold()
            
            Text(restaurant.description)
                .font(.system(size: 14))
                .lineLimit(2)
            
            Text(String(restaurant.rating))
                .font(.system(size: 14))
                .lineLimit(2)
            
        } .padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
                
            )
        )
    }
    
}


struct  RestaurantRow_Previews: PreviewProvider {
    static var previews: some View {
        let res = RestaurantModel(
            id: "1",
            name: "Gudeg Pawon",
            description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle",
            pictureId: "14",
            rating: 1,
            favorite: true)
        
        return RestaurantRow(restaurant: res)
    }
    
}
