//
//  BusRouteUITests.swift
//  BusRouteUITests
//
//  Created by Rathi on 3/31/21.
//

import XCTest

class BusRouteUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testRouteScreenElements() throws {
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
        sleep(1)
        let tablesQuery = app.tables["TableView"]
        XCTAssert(tablesQuery.waitForExistence(timeout: 5.0))
        let cellsQuery = tablesQuery.cells.containing(.staticText, identifier:"E city")
        
        let routesNavigationBar = app.navigationBars["Routes"]
        let routesStaticText = routesNavigationBar.staticTexts["Routes"]
        XCTAssert(routesStaticText.exists, "Nav bar title is wrong or missing")
        XCTAssert(cellsQuery.staticTexts["E city"].exists, "Source Value is wrong or missing")
        
        XCTAssert(cellsQuery.staticTexts["Silk Board"].exists, "Destination Value is wrong or missing")
        XCTAssert(cellsQuery.staticTexts["Apr 04, 23:40"].exists, "start time Value is wrong or missing")
        XCTAssert(cellsQuery.staticTexts["Apr 05, 02:40"].exists, "end time Value is wrong or missing")
        XCTAssert(cellsQuery.staticTexts["Total seat: 30"].exists, "total seat Value is wrong or missing")
        XCTAssert(cellsQuery.staticTexts["Available seat: 15"].exists, "available seat Value is wrong or missing")
        XCTAssert(cellsQuery.staticTexts["Travel time: 180 min"].exists, "travel time Value is wrong or missing")
        XCTAssert(cellsQuery.staticTexts["Departure in:"].exists, "departure time heading Value is missing")
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
