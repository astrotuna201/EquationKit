//
//  PolynomialsExponentiatedTests.swift
//  EquationKitTests
//
//  Created by Alexander Cyon on 2018-08-17.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

import Foundation
import XCTest
@testable import EquationKit

class PolynomialsExponentiatedTests: XCTestCase {
    func test﹙𝑥＋𝟙﹚²() {
        let eq = (x + 1)^^2
        XCTAssertEqual(eq, (x + 1) * (x + 1))
        XCTAssertEqual(eq, x² + 2*x + 1)
        XCTAssertEqual(eq, (1 + x)^^2)
    }

    func test﹙𝑥＋𝟙﹚³() {
        let eq = (x + 1)^^3
        XCTAssertEqual(eq, (x + 1) * (x + 1) * (x + 1))
        XCTAssertEqual(eq, x³ + 3*x² + 3*x + 1)
    }

    func test﹙𝑥－𝟙﹚²() {
        let eq = (x - 1)^^2
        XCTAssertEqual(eq, (x - 1) * (x - 1))
        XCTAssertEqual(eq, x² - 2*x + 1)
    }

    func test﹙𝑥－𝟙﹚³() {
        let eq = (x - 1)^^3
        XCTAssertEqual(eq, (x - 1) * (x - 1) * (x - 1))
        XCTAssertEqual(eq, x³ - 3*x² + 3*x - 1)
    }

    func test𝑥·𝑥²＋𝑥²·𝑥－𝟚𝑥³() {
        let eq: Polynomial = x*x² + x²*x - 2*x³
        XCTAssertEqual(eq.description, "")
        XCTAssertEqual(eq, 0)
    }

    func test﹙𝑥－𝟙﹚⁹() {
        let eq = (x - 1)^^9
        XCTAssertEqual(eq.asString(sorting: .descendingExponent), "x⁹ - 9x⁸ + 36x⁷ - 84x⁶ + 126x⁵ - 126x⁴ + 84x³ - 36x² + 9x - 1")
        XCTAssertEqual(eq, x⁹ - 9*x⁸ + 36*x⁷ - 84*x⁶ + 126*x⁵ - 126*x⁴ + 84*x³ - 36*x² + 9*x - 1)
        XCTAssertEqual(eq.solve() { x <- 1 }!, 0)
        XCTAssertEqual(eq.solve() { x <- 2 }!, 1)
        XCTAssertEqual(eq.solve() { x <- 3 }!, 512)
        XCTAssertEqual(eq.solve() { x <- 4 }!, 19683)
    }
}