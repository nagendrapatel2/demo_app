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
        sut = UserListViewModel(userListWebService: MockUserListService(resultForResponse: .success([User.preview])), state: .idle)
        // when
        sut.getUsersList()
        let expectationDataLoad = expectation(description: "Data loaded successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Then
            XCTAssertNotNil(self.sut.usersList)
            XCTAssertEqual(self.sut.usersList.count, 1)
            guard case .loaded = self.sut.state else {
                XCTFail("Expected status loaded, but was \(self.sut.state )")
                return
            }
            
            expectationDataLoad.fulfill()
        }
        await fulfillment(of: [expectationDataLoad])
        
    }
    
    @MainActor func testGetUserListWithFailure() async {
        
        //Given
        sut = UserListViewModel(userListWebService: MockUserListService(resultForResponse: .failure(MockError.error)), state: .idle)
        // when
        sut.getUsersList()
        let expectationDataLoad = expectation(description: "Error occurred")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //Then
            XCTAssertNotNil(self.sut.usersList)
            XCTAssertEqual(self.sut.usersList.count, 0)
            guard case .failed( _) = self.sut.state else {
                XCTFail("Expected status failed, but was \(self.sut.state )")
                return
            }
            expectationDataLoad.fulfill()
        }
        await fulfillment(of: [expectationDataLoad])
        
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
