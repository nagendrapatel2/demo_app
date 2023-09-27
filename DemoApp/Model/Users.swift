//
//  Users.swift
//  DemoApp
//
//  Created by Nagendra Patel  on 31/08/23.
//

import Foundation
// MARK: - Users
struct Users: Codable {
    let success: Bool
    let time, message: String
    let totalUsers, offset, limit: Int
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case success, time, message
        case totalUsers = "total_users"
        case offset, limit, users
    }
    init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.success = try container.decode(Bool?.self, forKey: .success) ?? false
           self.time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
           self.message = try container.decode(String?.self, forKey: .message) ?? ""
           self.totalUsers = try container.decode(Int?.self, forKey: .totalUsers) ?? 0
           self.offset = try container.decode(Int?.self, forKey: .offset) ?? 0
           self.limit = try container.decode(Int?.self, forKey: .limit) ?? 0
           self.users = try container.decode([User]?.self, forKey: .users) ?? []
       }
}

// MARK: - User
struct User: Codable ,Identifiable {
    let gender: Gender
    let id: Int
    let dateOfBirth, job, city, zipcode: String
    let latitude: Double
    let profilePicture: String
    let firstName, lastName, email, phone: String
    let street, state, country: String
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case gender, id
        case dateOfBirth = "date_of_birth"
        case job, city, zipcode, latitude
        case profilePicture = "profile_picture"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, street, state, country, longitude
    }
    
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}
