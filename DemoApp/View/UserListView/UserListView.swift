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
        switch userListViewModel.state {
        case .idle:
            Color.clear.task {
                 userListViewModel.getUsersList()
            }
        case .loading:
            ProgressView()
        case .failed(let error):
            VStack {
                Text("⚠️ \(error.localizedDescription)")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding()
        case .loaded:
            NavigationView {
                List {
                    ForEach (userListViewModel.usersList) { user in
                        UserListCellView(user: user)
                    }
                }
                .refreshable(action:  userListViewModel.refreshData)
                .navigationBarTitle(Text("User List"))
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
