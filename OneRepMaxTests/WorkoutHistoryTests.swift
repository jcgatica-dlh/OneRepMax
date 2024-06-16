//
//  WorkoutHistoryTests.swift
//  OneRepMaxTests
//
//  Created by Juan Gatica on 6/16/24.
//

import Foundation
import XCTest
@testable import OneRepMax

final class WorkoutHistoryTests: XCTestCase {
    func testCollating() throws {
        let workouts = [
            Workout(date: .now, name: "A", reps: 3, weight: 25),
            Workout(date: .now.advanced(by: -100), name: "B", reps: 5, weight: 30),
            Workout(date: .now.advanced(by: -110), name: "B", reps: 3, weight: 30)
        ]
        let history = WorkoutHistory.collateData(workouts)
        XCTAssert(history.count == 2, "Wrong number of exercises")
        XCTAssert(history.first!.name == "A", "Wrong exercise at top")
        XCTAssert(history.last!.workouts.count == 2, "Incorrect number of workouts on last exercise")
    }
}
