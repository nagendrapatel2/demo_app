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
    @Published private (set) var state : LoadingState<Void> = .loading
    var userListWebService :  UserListRepository
    init(userListWebService :  UserListRepository =  UserListWebService()) {
        self.userListWebService = userListWebService
        getUsersList()
    }
    //get userList data from Server
    func getUsersList()  {
        Task { @MainActor in
            state = .loading
            do {
                usersList = try await userListWebService.fetchUserList()
                state = .loaded
            } catch (let error){
                state = .failed(error)
            }
        }
    }
    func getErrorMessage(for error: Error) -> String {
        return "An error occurred: \(error.localizedDescription)"
    }
    // refresh Data
    @Sendable
    func refreshData() {
        getUsersList()
    }
}
