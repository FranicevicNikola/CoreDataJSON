//
//  DetailView.swift
//  CoreDataJSON
//
//  Created by Master Family on 24/09/2020.
//

import SwiftUI

struct DetailView: View {
    
    var user: UserJSON
    
    var body: some View {
        VStack {
            HStack {
                Text("Name: \(user.name)")
            }
            HStack {
                Text("e-Mail: \(user.email)")
            }
            
            NavigationView {
                List(user.friends, id: \.id) { friend in
                    Text(friend.name)
                }
                .navigationBarTitle("Friends", displayMode: .inline)
            }
            
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: )
//    }
//}
