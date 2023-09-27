//
//  AppServices+Preview.swift.swift
//  DemoApp
//
//  Created by Nagendra on 01/09/23.
//

import Foundation
struct PreviewNetwork: UserListRepository {
    func fetchUserList() async throws -> [User] {
        let response: Users = try JSONDecoder().decode(Users.self, from: Self.userMockResponse)
        return response.users
    }
    var session: URLSession = .shared
    var baseURL: String = ""
}

extension User {
    static let preview = User(gender: Gender.female, id: 1, dateOfBirth: "1924-05-14T00:00:00", job: "Herbalist", city: "Humphreyfurt", zipcode: "79574", latitude: 112.16014, profilePicture: "https://api.slingacademy.com/public/sample-users/1.png", firstName: "Kayla", lastName: "Lopez", email: "kayla.lopez.1@slingacademy.com", phone: "800-865-4932", street: "3388 Roger Wells Apt", state: "4564 Gamble Light", country: "Greenland", longitude: 112.16014)
}
extension PreviewNetwork {
    static var userMockResponse: Data = """
            {
            "success": true,
            "time": "2023-09-01 04:08:26 UTC",
            "message": "Sample data for testing and learning purposes",
            "total_users": 1000,
            "offset": 0,
            "limit": 10,
            "users": [
            {
            "gender": "female",
            "id": 1,
            "date_of_birth": "2002-04-26T00:00:00",
            "job": "Herbalist",
            "city": "Humphreyfurt",
            "zipcode": "79574",
            "latitude": 13.032103,
            "profile_picture": "https://api.slingacademy.com/public/sample-users/1.png",
            "first_name": "Kayla",
            "last_name": "Lopez",
            "email": "kayla.lopez.1@slingacademy.com",
            "phone": "+1-697-415-3345x5215",
            "street": "3388 Roger Wells Apt. 010",
            "state": "Vermont",
            "country": "Jordan",
            "longitude": 112.16014
             },
             {
            "gender": "female",
            "id": 2,
            "date_of_birth": "1924-05-14T00:00:00",
            "job": "Technical author",
            "city": "West Angelaside",
            "zipcode": "44459",
            "latitude": 51.5214995,
            "profile_picture": "https://api.slingacademy.com/public/sample-users/2.png",
            "first_name": "Tina",
            "last_name": "Patrick",
            "email": "tina.patrick.2@slingacademy.com",
            "phone": "800-865-4932",
            "street": "4564 Gamble Light Suite 885",
            "state": "Kansas",
            "country": "Greenland",
            "longitude": -21.22766
             },
             {
            "gender": "female",
            "id": 3,
            "date_of_birth": "1998-04-23T00:00:00",
            "job": "Psychologist, occupational",
            "city": "South Maria",
            "zipcode": "69755",
            "latitude": 61.273996,
            "profile_picture": "https://api.slingacademy.com/public/sample-users/3.png",
            "first_name": "Brittany",
            "last_name": "Bradford",
            "email": "brittany.bradford.3@slingacademy.com",
            "phone": "205-439-1326",
            "street": "0193 Amy Isle",
            "state": "Indiana",
            "country": "Micronesia",
            "longitude": 147.58546
            },
            {
            "gender": "female",
            "id": 4,
            "date_of_birth": "1987-12-02T00:00:00",
            "job": "Proofreader",
            "city": "Danaberg",
            "zipcode": "22397",
            "latitude": -75.9252065,
            "profile_picture": "https://api.slingacademy.com/public/sample-users/4.png",
            "first_name": "Lisa",
            "last_name": "Thomas",
            "email": "lisa.thomas.4@slingacademy.com",
            "phone": "(660)262-7257",
            "street": "3500 Miller Springs Suite 728",
            "state": "Connecticut",
            "country": "Sudan",
            "longitude": -88.334238
             },
             {
            "gender": "female",
            "id": 5,
            "date_of_birth": "1995-08-13T00:00:00",
            "job": "Health service manager",
            "city": "North Paul",
            "zipcode": "44517",
            "latitude": -16.2496365,
            "profile_picture": "https://api.slingacademy.com/public/sample-users/5.png",
            "first_name": "Danielle",
            "last_name": "Taylor",
            "email": "danielle.taylor.5@slingacademy.com",
            "phone": "+1-308-453-1561",
            "street": "7784 Obrien Hollow Suite 953",
            "state": "Pennsylvania",
            "country": "Oman",
            "longitude": -87.298799
            },
            {
            "gender": "male",
            "id": 6,
            "date_of_birth": "1902-08-06T00:00:00",
            "job": "Financial manager",
            "city": "Amymouth",
            "zipcode": "52484",
            "latitude": -78.303175,
            "profile_picture": "https://api.slingacademy.com/public/sample-users/6.png",
            "first_name": "Joshua",
            "last_name": "Delgado",
            "email": "joshua.delgado.6@slingacademy.com",
            "phone": "216-424-8988x0838",
            "street": "1663 Simmons Points",
            "state": "Colorado",
            "country": "Angola",
            "longitude": -141.625538}]}
            """.data(using: .utf8)!
}


class PreviewData : UserListViewModel {
    init(userList : [User],state : LoadingState<Void> = LoadingState<Void>.idle) {
        super.init(userListWebService: MockUserListService())
        self.usersList = userList
        self.state = state
    }
}

struct MockUserListService : UserListRepository {
    var session: URLSession = .shared
    var baseURL: String = ""
    var resultForResponse : Result <[User] ,Error> = .success([User.preview])
    func fetchUserList() async throws -> [User] {
        try resultForResponse.get()
    }
}
