//
//  OneRepMaxTests.swift
//  OneRepMaxTests
//
//  Created by Juan Gatica on 6/13/24.
//

import XCTest
@testable import OneRepMax

final class WorkoutTests: XCTestCase {
    func testParsing() throws {
        let inputString = """
Oct 11 2020,Back Squat,6,245
Oct 05 2020,Barbell Bench Press,4,45
"""
        let result = try Workout.decodeWorkouts(inputString)
        XCTAssert(result.count == 2, "Unable to parse")
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.year, .month, .day],
            from: result.first!.date
        )
        XCTAssert(components.year == 2020, "Year wrong")
        XCTAssert(components.month == 10, "Month wrong")
        XCTAssert(components.day == 11, "Day wrong")
    }
}
