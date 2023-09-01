//
//  UserListViewModelTest.swift
//  DemoAppTests
//
//  Created by Nagendra Patel  on 31/08/23.
//

import XCTest
@testable import DemoApp
final class DemoAppTests: XCTestCase {
    var sut : UserListViewModel!
    
    @MainActor override func setUp() {
        sut = UserListViewModel()
    }
    
    @MainActor func testGetUserListWithSuccess() async {
        //Given
        let mockData = MockUserListResponse(resultForResponse: .success([User.preview]))
        do {
            // when
            sut.usersList = try await mockData.fetchUserList()
        } catch {
        }
        //Then
        XCTAssertNotNil(sut.usersList)
        XCTAssertEqual(sut.usersList.count, 1)
        
    }
    
    @MainActor func testGetUserListWithFailure() async {
        //Given
        let mockData = MockUserListResponse(resultForResponse: .failure(MockError.error))
        do {
            // when
            sut.usersList = try await mockData.fetchUserList()
        } catch{
            //Then
            XCTAssertEqual(error as? MockError ,MockError.error)
        }
        XCTAssertEqual(sut.usersList.count, 0)
        
    }
    
    func testValidJsonSuccess(){
        //Give
        let mockData = PreviewNetwork.userMockResponse
        // when
        let sut : Users = try! JSONDecoder().decode(Users.self, from: mockData)
        //Then
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.limit,10)
        XCTAssertEqual(sut.users.count,6)
        XCTAssertEqual(sut.users.first?.firstName,"Kayla")
    }
    override func tearDown() {
        sut = nil
    }
}

struct MockUserListResponse : UserListRepository {
    var session: URLSession = .shared
    var baseURL: String = ""
    var resultForResponse : Result <[User] ,Error> = .success([])
    func fetchUserList() async throws -> [User] {
        try resultForResponse.get()
    }
}

enum MockError : Error {
    case error
}
