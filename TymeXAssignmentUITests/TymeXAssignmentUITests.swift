//
//  TymeXAssignmentUITests.swift
//  TymeXAssignmentUITests
//
//  Created by thanh tien on 2/6/25.
//

import XCTest
import UIKit
import SwiftUI
@testable import TymeXAssignment

final class TymeXAssignmentUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testUserListBasicFlow() throws {
        let list = app.descendants(matching: .any).matching(identifier: "userList").firstMatch
        XCTAssertTrue(list.exists, "No list or scroll view found within the app")

        let firstCell = list.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First cell did not appear")

        let username = firstCell.staticTexts.firstMatch
        XCTAssertTrue(username.exists)
        
        let cellCoordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.5))
        cellCoordinate.tap()

        let backButton = app.buttons["backButton"]
        let exists = backButton.waitForExistence(timeout: 10)
        XCTAssertTrue(exists, "Back button with identifier 'backButton' not found after 10 seconds")

        backButton.tap()

        XCTAssertTrue(list.waitForExistence(timeout: 5))
    }
    
    func testUserListPagination() throws {
        let list = app.descendants(matching: .any).matching(identifier: "userList").firstMatch
        XCTAssertTrue(list.exists, "No list or scroll view found within the app")

        let firstCell = list.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First cell did not appear")

        let initialCellCount = list.cells.count
        XCTAssertGreaterThan(initialCellCount, 0)
        
        list.swipeUp(velocity: .fast)
        
        sleep(2)
        
        let newCellCount = list.cells.count
        XCTAssertGreaterThan(newCellCount, initialCellCount)
    }
    
    func testUserDetailScreen() throws {
        let list = app.descendants(matching: .any).matching(identifier: "userList").firstMatch
        
        XCTAssertTrue(list.exists, "No list or scroll view found within the app")

        let firstCell = list.cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First cell did not appear")
        
        let cellCoordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.5))
        cellCoordinate.tap()

        let followerTitle = app.staticTexts["Followers"]
        XCTAssertTrue(followerTitle.waitForExistence(timeout: 5))
        
        let followingTitle = app.staticTexts["Following"]
        XCTAssertTrue(followingTitle.exists)
        
        let blogTitle = app.staticTexts["Blog"]
        XCTAssertTrue(blogTitle.exists)
        
        let backButton = app.buttons["backButton"]
        let exists = backButton.waitForExistence(timeout: 10)
        XCTAssertTrue(exists, "Back button with identifier 'backButton' not found after 10 seconds")
        
        backButton.tap()
        
        XCTAssertTrue(list.waitForExistence(timeout: 5))
    }
    
    func testPullToRefresh() throws {
        let list = app.descendants(matching: .any).matching(identifier: "userList").firstMatch
        
        XCTAssertTrue(list.exists, "No list or scroll view found within the app")
                
        let cells = list.cells.count > 0 ? list.cells : list.otherElements
        let firstCell = cells.firstMatch
        let cellExists = firstCell.waitForExistence(timeout: 5)
        XCTAssertTrue(cellExists, "First cell did not appear within 5 seconds")
        
        let start = list.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let end = list.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 1.0))
        start.press(forDuration: 0.1, thenDragTo: end)
        
        sleep(3)
        
        XCTAssertTrue(list.exists, "List disappeared after refresh")
        XCTAssertTrue(firstCell.exists, "First cell disappeared after refresh")
    }
}
