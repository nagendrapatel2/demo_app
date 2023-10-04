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
    
    @MainActor func testGetUserListWithSuccess() async {
        //Given
        sut = UserListViewModel(userListWebService: MockUserListService(resultForResponse: .success([User.preview])))
        // when
        sut.getUsersList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Then
            XCTAssertNotNil(self.sut.usersList)
            XCTAssertEqual(self.sut.usersList.count, 1)
            XCTAssertEqual(self.sut.usersList.first?.id, 1)
            XCTAssertEqual(self.sut.usersList.first?.firstName,"Kayla")
            guard case .loaded = self.sut.state else {
                XCTFail("Expected status loaded, but was \(self.sut.state )")
                return
            }
        }
    }
    
    @MainActor func testGetUserListWithFailure() async {
        
        //Given
        sut = UserListViewModel(userListWebService: MockUserListService(resultForResponse: .failure(MockError.error)))
        // when
        sut.getUsersList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Then
            XCTAssertNotNil(self.sut.usersList)
            XCTAssertEqual(self.sut.usersList.count, 0)
            guard case .failed( _) = self.sut.state else {
                XCTFail("Expected status failed, but was \(self.sut.state )")
                return
            }
            
        }
    }
    @MainActor func testRefreshDataWithSuccess() async {
        //Given
        sut = UserListViewModel(userListWebService: MockUserListService(resultForResponse: .success([User.preview])))
        // when
        sut.refreshData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Then
            XCTAssertNotNil(self.sut.usersList)
            XCTAssertEqual(self.sut.usersList.count, 1)
            XCTAssertEqual(self.sut.usersList.first?.id, 1)
            XCTAssertEqual(self.sut.usersList.first?.firstName, "Kayla")
            guard case .loaded = self.sut.state else {
                XCTFail("Expected status loaded, but was \(self.sut.state )")
                return
            }
        }
    }
    
    @MainActor func testRefreshDataWithFailure() async {
        
        //Given
        sut = UserListViewModel(userListWebService: MockUserListService(resultForResponse: .failure(MockError.error)))
        // when
        sut.refreshData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Then
            XCTAssertNotNil(self.sut.usersList)
            XCTAssertEqual(self.sut.usersList.count, 0)
            guard case .failed( _) = self.sut.state else {
                XCTFail("Expected status failed, but was \(self.sut.state )")
                return
            }
            
        }
    }
    func testValidJsonSuccess(){
        //Give
        let mockData = PreviewNetwork.userMockResponse
        // when
        do {
            let sut : Users = try JSONDecoder().decode(Users.self, from: mockData)
            //Then
            XCTAssertNotNil(sut)
            XCTAssertEqual(sut.limit,10)
            XCTAssertEqual(sut.users.count,6)
            XCTAssertEqual(sut.users.first?.firstName,"Kayla")
        }catch {
            XCTFail("JSON decoding failed with error: \(error)")
        }
    }
    
    func testInvalidJsonWithFailure(){
        //Give
       let mockData : Data = """
             {
             "success": true,
             "time": "2023-09-01 04:08:26 UTC",
             "message": "Sample data for testing and learning purposes",
             "total_users": 1000,
             "offset": 0,
             "limit": 10,
             "users":
             """.data(using: .utf8) ?? Data()
        // when
        do {
            let _ : Users = try JSONDecoder().decode(Users.self, from: mockData)
            XCTFail("JSON decoding failed with error")
        }catch (let error){
            XCTAssertNotNil(error)
        }
        //Then
      
    }
    func testErrorMessageFromErrorToString(){
        sut = UserListViewModel(userListWebService: MockUserListService())
        let error = APIError.invalidURL
        let errorMessage = sut.getErrorMessage(for: error)
        XCTAssertEqual(errorMessage, "An error occurred: Provided URL is invalid")
    }
    
    override func tearDown() {
        sut = nil
    }
}
