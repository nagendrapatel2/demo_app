//
//  MockDataUserList.swift
//  DemoApp
//
//  Created by Nagendra on 27/09/23.
//
#if DEBUG
import Foundation

struct MockUserListService : UserListRepository {
    var session: URLSession = .shared
    var baseURL: String = ""
    var resultForResponse : Result <[User] ,Error> = .success([User.preview])
    func fetchUserList() async throws -> [User] {
        try resultForResponse.get()
    }
}

enum MockError : Error {
    case error
}

#endif
