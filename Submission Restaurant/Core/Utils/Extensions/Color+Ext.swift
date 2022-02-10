//
//  Color+Ext.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/11/21.
//

import SwiftUI


extension Color {
    
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
