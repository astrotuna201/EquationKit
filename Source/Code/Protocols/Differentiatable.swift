//
//  Differentiatable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-15.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

public protocol Differentiatable {
    associatedtype DifferentiationResult
    func differentiateWithRespectTo(_ variableToDifferentiate: Variable) -> DifferentiationResult?
}
