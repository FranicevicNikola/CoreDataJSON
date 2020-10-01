//
//  UserDetailView.swift
//  CoreDataJSON
//
//  Created by Master Family on 01/10/2020.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    var body: some View {
        VStack {
            Text(user.wrappedAbout)
            List(user.friendsArray, id: \.self) { friend in
                Text(friend.wrappedName)
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
    }
}
