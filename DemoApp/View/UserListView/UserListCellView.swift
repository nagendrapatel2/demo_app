//
//  UserListCellView.swift
//  DemoApp
//
//  Created by Nagendra on 31/08/23.
//

import SwiftUI
struct UserListCellView: View {
    var user: User
    var body: some View {
        NavigationLink(destination: UserDetailView(selectedUser: user)) {
            UserView(user: user)
        }
    }
}
