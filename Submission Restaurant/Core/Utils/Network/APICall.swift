//
//  APICall.swift
//  Submission Restaurant
//
//  Created by Galfari on 14/12/21.
//

import Foundation

struct API {
    static let baseUrl = "https://restaurant-api.dicoding.dev/"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        
        case restaurants
        
        public var url: String {
            switch self {
            case .restaurants: return "\(API.baseUrl)list"
            }
        }
    }
}
