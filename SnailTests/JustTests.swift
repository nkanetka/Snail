//  Copyright © 2016 Compass. All rights reserved.

import Foundation
import XCTest
@testable import Snail

class JustTests: XCTestCase {
    func testJust() {
        var result: Int?
        var done = false
        let subject = Just(1)
        subject.subscribe(
            onNext: { value in result = value },
            onDone: { done = true }
        )
        XCTAssertEqual(1, result)
        XCTAssertTrue(done)
    }
}
