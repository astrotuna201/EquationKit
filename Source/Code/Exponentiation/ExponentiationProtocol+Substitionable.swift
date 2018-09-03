//
//  ExponentiationProtocol+Substitionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Substitionable
public extension ExponentiationProtocol {

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return variable.uniqueVariables
    }

    func substitute(with substitutions: Set<Substitution<NumberType>>, modulus: Modulus<NumberType>?) -> PolynomialType<NumberType> {

        return parse(
            substitutionable: variable,
            substitutions: substitutions,
            modulus: modulus,
            handleNumber: { base in
                base.raised(to: exponent)
            },
            handleAlgebraic: { poly in
                return poly.raised(to: self.exponent.asInteger)
            }
        )
    }
}

