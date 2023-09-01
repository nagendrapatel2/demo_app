//
//  UserListViewModel.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import SwiftUI
import Combine
class UserListViewModel : ObservableObject {
    @Published  var usersList = [User]()
    @Published private(set) var state = LoadingState<Void>.idle
    //get userList data from Server
    func getUsersList() {
        Task { @MainActor in
            state = .loading
            do {
                usersList = try await UserListWebService().fetchUserList()
                state = .loaded
            } catch (let error){
                state = .failed(error)
            }
        }
    }
    // refresh Data
    @Sendable
    func refreshData() {
        getUsersList()
    }
}
