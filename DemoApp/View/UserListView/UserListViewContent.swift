//
//  UserListViewContent.swift
//  DemoApp
//
//  Created by Nagendra on 26/09/23.
//

import SwiftUI
struct UserListViewContent: View {
    @ObservedObject var userListViewModel: UserListViewModel
    var body: some View {
        NavigationStack {
            List {
                ForEach(userListViewModel.usersList) { user in
                    UserListCellView(user: user).accessibilityIdentifier("userListCell")
                }
            }.accessibilityIdentifier("userlist")
            .refreshable(action: userListViewModel.refreshData)
            .navigationBarTitle(Text(Constants.StringTitle.userListTitle))
        }
    }
}

struct UserListViewContent_Previews: PreviewProvider {
    static var previews: some View {
        UserListViewContent(userListViewModel: UserListViewModel(userListWebService: MockUserListService()))
    }
}
