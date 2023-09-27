//
//  UserListView.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import SwiftUI
struct UserListView: View {
    @StateObject  var userListViewModel = UserListViewModel()
    var body: some View {
        switch userListViewModel.state {
               case .idle:
                    Color.clear.task { userListViewModel.refreshData()}
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(errorMessage: userListViewModel.getErrorMessage(for: error))
                case .loaded:
                    UserListViewContent(userListViewModel: userListViewModel)
                }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(userListViewModel: PreviewData(userList: [User.preview], state: .loaded))
    }
}
