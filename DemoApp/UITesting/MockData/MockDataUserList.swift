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

struct MockAPIClient: APIClient {
    var path: String
    var method: String
    var headers: [String: String]?
    func body() throws -> Data? {
        // Implement this function as needed for testing
        return nil
    }
}

#endif
