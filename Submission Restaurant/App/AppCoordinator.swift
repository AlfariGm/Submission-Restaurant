//
//  ContentView.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/11/21.
//

import SwiftUI

struct AppCoordinator: View {
    
    @State private var selection = 0
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house.fill", title: "Home")
            }
            
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart.fill", title: "Favorite")
            }
            
            NavigationView {
                ProfileView()
            }.tabItem {
                TabItem(imageName: "person.fill", title: "About")
            }
        }
    }
}

//extension UITabBarController {
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        let standardAppearance = UITabBarAppearance()
//
//        standardAppearance.configureWithOpaqueBackground()
//        standardAppearance.configureWithTransparentBackground()
//
//        tabBar.standardAppearance = standardAppearance
//    }
//}
//
//
struct AppCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinator()
    }
}

