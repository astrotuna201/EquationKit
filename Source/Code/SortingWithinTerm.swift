//
//  SortingWithinTerm.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-21.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public enum SortingWithinTerm: Sorting {
    case descendingExponent
    case variablesAlphabetically
}

public extension SortingWithinTerm {


    var comparing: (Exponentiation, Exponentiation) -> (ComparisonResult) {
        switch self {
        case .descendingExponent: return { $0.exponent.compare(to: $1.exponent) }
        case .variablesAlphabetically: return { $0.variable.name.compare(to: $1.variable.name) }
        }
    }

    var targetComparisonResult: ComparisonResult {
        switch self {
        case .variablesAlphabetically: return .orderedAscending
        case .descendingExponent: return .orderedDescending
        }
    }
}
public extension Array where Element == SortingWithinTerm {
    static var `default`: [SortingWithinTerm] {
        return [.descendingExponent, .variablesAlphabetically]
    }
}

public extension Array where Element == Exponentiation {

    func sorted(by sorting: SortingWithinTerm) -> [Exponentiation] {
        return sorted(by: [sorting])
    }

    func sorted(by sorting: [SortingWithinTerm] = .default) -> [Exponentiation] {
        guard let first = sorting.first else { return self }
        return sorted(by: first.areInIncreasingOrder(tieBreakers: sorting.droppingFirstNilIfEmpty()))
    }

    func merged() -> [Exponentiation] {
        var count: [Variable: Double] = [:]
        for exponentiation in self {
            count[exponentiation.variable] += exponentiation.exponent
        }
        return count.map { Exponentiation($0.key, exponent: $0.value) }
    }
}