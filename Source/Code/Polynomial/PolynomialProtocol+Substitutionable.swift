//
//  PolynomialProtocol+Substitutionable.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-24.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - Substitutionable
public extension PolynomialProtocol {

    var uniqueVariables: Set<VariableStruct<NumberType>> {
        return Set(terms.flatMap { Array($0.uniqueVariables) })
    }

    func substitute(constants: Set<ConstantStruct<NumberType>>, modulus: Modulus<NumberType>?) -> Substitution<NumberType> {
        return parseMany(
            substitutionables: terms,
            constants: constants,
            modulus: modulus,
            manyHandleAllNumbers: { values in
                values.reduce(self.constant, { $0 + $1 })
        },
            manyHandleMixedReduce: (initialResult: Self.atom0, combine: { Poly($0).adding(other: Poly($1)) })
        )
    }
}

private extension PolynomialProtocol {
    static var atom0: Atom { return Self(constant: .zero) as Atom }

}