//
//  BusRouteTests.swift
//  BusRouteTests
//
//  Created by Rathi on 3/31/21.
//

import XCTest
import OHHTTPStubsSwift
import OHHTTPStubs

@testable import BusRoute

class BusRouteTests: XCTestCase {

    var presenter: BusRoutePresenterInput!
    var expectation = XCTestExpectation()


    override func setUp() {
        expectation = self.expectation(description: "fetch Route API request")
        presenter = BusRoutePresenter(output: self)
    }

    func testSearchRepoAPI() throws {
        setStubForSearchRoute()
        presenter.getBusRouteList()
        wait(for: [expectation], timeout: 5)
        XCTAssert(presenter.getTripListCount() == 2, "response should contain two elements")
        let item = presenter.getTripDetail(index: 0)!
        XCTAssert(Trip.primaryKey() == "id", "primary key is different")
        XCTAssert(RouteInfo.primaryKey() == "id", "primary key is different")

        XCTAssert(item.tripID == "r002", "value is different")
        XCTAssert(item.totalSeats == 30, "value is different")
        XCTAssert(item.avaiable == 15, "value is different")
        XCTAssert(item.tripStartTime == "23:40", "value is different")
        XCTAssert(item.route?.id == "r002", "value is different")
        XCTAssert(item.route?.name == "k-12", "value is different")
        XCTAssert(item.route?.source == "E city", "value is different")
        XCTAssert(item.route?.destination == "Silk Board", "value is different")
        XCTAssert(item.route?.getTripDuration() == 180, "value is different")

    }
    
    func testSearchRepoAPIEmptyTripResponse() throws {
        setStubForSearchRouteNoTrip()
        presenter.getBusRouteList()
        wait(for: [expectation], timeout: 5)
        XCTAssert(presenter.getTripListCount() == 0, "response should be empty array")
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    override func tearDown() {
        super.tearDown()
        HTTPStubs.removeAllStubs()
    }
}

extension XCTestCase {
    func setStubForSearchRoute() {
        setStub("/data", jsonName: "SRPdummyresponse.json")
    }
    func setStubForSearchRouteNoTrip() {
        setStub("/data", jsonName: "SRPNoresponse.json")
    }

    func setStub(_ urlPath: String, jsonName: String) {
        stub(condition: pathStartsWith(urlPath)) { _ in
            let stubPath = OHPathForFile(jsonName, type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
}

extension BusRouteTests: BusRoutePresenterOutput {
    public func updateUI() {
        expectation.fulfill()
    }

    public func updateUIWithNoData() {
        expectation.fulfill()
    }

    public func showLoadingIndicator() { }

    public func hideLoadingIndicator() { }

    public func showErrorDialog(with error: Error) { }


}
