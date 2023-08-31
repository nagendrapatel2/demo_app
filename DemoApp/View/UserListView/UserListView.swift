//
//  UserListView.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var userListViewModel = UserListViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach (userListViewModel.usersList) { user in
                    UserListCellView(user: user)
                    }
            }
            .navigationBarTitle(Text("User List"))
            }
        .task {
            await userListViewModel.getUsersList()
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
