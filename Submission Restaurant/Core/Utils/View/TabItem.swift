//
//  TabItem.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/01/22.
//

import SwiftUI

struct TabItem: View {

  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }
}
