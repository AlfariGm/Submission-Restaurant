//
//  ProfileController.swift
//  Submission Restaurant
//
//  Created by Galfari on 22/12/21.
//

import SwiftUI
import AsyncDisplayKit
import RxCocoa

struct ProfileView: View {
    
    var body: some View {

        NavigationView {
            VStack {
                Image("poto_profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250, alignment: .center)
                    .padding(10)
                
                Text("Alfari Gilian Matulessy")
                    .padding(5)
                    .font(.system(size: 20, weight: .bold, design: .default))
                
                Text("alfari.matulessy@gmail.com")
                    .font(.system(size: 20, weight: .semibold, design: .default))
                
            }
            
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

extension ProfileView {
    
    var spacer: some View {
        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
