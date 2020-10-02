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
        List(user.friendsArray, id: \.id) { friend in
            Text(friend.wrappedName)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User())
    }
}
