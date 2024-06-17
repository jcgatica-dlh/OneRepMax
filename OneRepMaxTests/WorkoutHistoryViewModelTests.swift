//
//  WorkoutHistoryViewModelTests.swift
//  OneRepMaxTests
//
//  Created by Juan Gatica on 6/17/24.
//

import Foundation
import XCTest
@testable import OneRepMax

final class WorkoutHistoryViewModelTests: XCTestCase {
    let secondsInDay = 60.0 * 60.0 * 24.0

    @MainActor
    func testMonthResolution() throws {
        let workouts = [
            Workout(date: .now.advanced(by: -secondsInDay*30*2), name: "A", reps: 3, weight: 25),
            Workout(date: .now.advanced(by: -secondsInDay*10), name: "A", reps: 5, weight: 30),
            Workout(date: .now, name: "A", reps: 3, weight: 30)
        ]
        let workoutHistory = WorkoutHistory(name: "A", workouts: workouts)
        let coordinator = RootCoordinator()
        let subject = WorkoutHistoryView.ViewModel(coordinator: coordinator, history: workoutHistory)
        XCTAssert(subject.labelResolution == .month, "Resolution was not month as expected")
    }
    
    @MainActor
    func testDayResolution() throws {
        let workouts = [
            Workout(date: .now.advanced(by: -secondsInDay*30), name: "A", reps: 3, weight: 25),
            Workout(date: .now.advanced(by: -secondsInDay*10), name: "A", reps: 5, weight: 30),
            Workout(date: .now, name: "A", reps: 3, weight: 30)
        ]
        let workoutHistory = WorkoutHistory(name: "A", workouts: workouts)
        let coordinator = RootCoordinator()
        let subject = WorkoutHistoryView.ViewModel(coordinator: coordinator, history: workoutHistory)
        XCTAssert(subject.labelResolution == .day, "Resolution was not day as expected")
    }
}
