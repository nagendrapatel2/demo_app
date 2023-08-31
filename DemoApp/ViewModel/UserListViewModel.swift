//
//  UserListViewModel.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import SwiftUI
import Combine
@MainActor
class UserListViewModel : ObservableObject {
    @Published  var usersList = [User]()
    @Published private(set) var state = LoadingState<Void>.idle
     func getUsersList() async {
        // state = .loading
        do {
            usersList = try await UserListWebService().fetchUserList()
            print("djhfdsjhfjsddddd")
            state = .loaded
        } catch (let error){
            print("djhfdsjhfjsdddddddeee")
           state = .failed(error)
        }
    }
}
