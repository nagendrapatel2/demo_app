//
//  UserListViewUITests.swift
//  DemoAppUITests
//
//  Created by Nagendra on 27/09/23.
//

import XCTest

final class UserListViewUITests: XCTestCase {

    var app : XCUIApplication!
    
    override  func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["_ui_testing"]
       
    }
    
    override func tearDown() {
        app = nil
    }
   
    func testUserListGetSuccess(){
                app.launchEnvironment = ["networking_success" : "1"]
        app.launch()
     let userView = app.otherElements["userViewContent"]
        XCTAssertTrue(userView.waitForExistence(timeout: 5))
        let title  = userView.navigationBars["User List"]
        XCTAssertTrue(title.staticTexts["User List"].exists)
        let listview = app.collectionViews["userlist"]
        XCTAssertTrue(listview.exists)
        XCTAssertTrue(listview.cells.count == 1)
        let cell = listview.cells.buttons["userListCell"]
        XCTAssertTrue(cell.exists)
        let userName = cell.staticTexts["Kayla Lopez"]
        XCTAssertTrue(userName.exists)
        cell.tap()
        let detailView = app.collectionViews.staticTexts["ID : 1"]
        XCTAssertTrue(detailView.exists)
        
    }
    func testUserListGetFailure(){
        app.launchEnvironment = ["networking_success" : "0"]
        app.launch()
       let errorView = app.staticTexts["errorView"]
        XCTAssertTrue(errorView.waitForExistence(timeout: 5))
//        let errorText  = app.staticTexts["errorText"]
//        XCTAssertTrue(errorText.exists)
                                                
   
    }
}
