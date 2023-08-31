//
//  UserWebService.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import Foundation

protocol UserListRepository: WebRepository {
    func fetchUserList() async throws -> [User]
}

struct UserListWebService: UserListRepository {
   
    let baseURL: String = "https://api.slingacademy.com/v1/sample-data"//AppEnvironment.baseURL + "/da-approvals-az"
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    func fetchUserList() async throws -> [User] {
        let response: Users = try await request(
                    endpoint: MyUserAPI.fetchUserList
                )
        return response.users
    }
}

extension UserListWebService {
    enum MyUserAPI: APIClient {
        case fetchUserList
        var path: String {
            switch self {
            case .fetchUserList:
                return "/users"
                
            }
        }
        var method: String {
            switch self {
            case .fetchUserList: return "GET"
            }
        }
            var headers: [String : String]? {
                nil
            }
            
            func body() throws -> Data? {
                nil
            }
        }
    }

