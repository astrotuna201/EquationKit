//
//  PolynomialProtocol+AbsoluteConvertible.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-31.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

// MARK: - AbsoluteConvertible
public extension PolynomialProtocol {
    func absolute() -> Self {
        return Self(terms: terms.absolute(), constant: constant.absolute())
    }
}
