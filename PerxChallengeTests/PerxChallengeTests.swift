//
//  PerxChallengeTests.swift
//  PerxChallengeTests
//
//  Created by James Robinson on 06/02/2023.
//

import XCTest
@testable import PerxChallenge

final class PerxChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test that the network call succeeds and results is not empty. Results should not be empty as there is no search term.
    func testCall() throws {
        NetworkClient.shared.fetchSearchMedication { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.results)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    // Testing with a search term
    func testCallWithSearch() throws {
        NetworkClient.shared.fetchSearchMedication(search: "PARA") { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.results)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    // Testing with pagination
    func testCallWithPagination() throws {
        NetworkClient.shared.fetchSearchMedication(skip: 100) { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.results)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }

}
