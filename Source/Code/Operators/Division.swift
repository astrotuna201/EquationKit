//
//  Division.swift
//  EquationKit
//
//  Created by Alexander Cyon on 2018-08-11.
//  Copyright © 2018 Sajjon. All rights reserved.
//

import Foundation

struct Div: Operator {
    let lhs: Expression
    let rhs: Expression
    let wrapInParenthesis: Bool
    init(lhs: Expression, rhs: Expression, wrapInParenthesis: Bool) {
        guard !lhs.number.equals(0), !rhs.number.equals(0) else { fatalError("Should handle case where either term equals to 0 elsewhere") }
        self.lhs = lhs
        self.rhs = rhs
        self.wrapInParenthesis = wrapInParenthesis
    }

    static var function: Function { return { $0 / $1 } }
    var operatorString: String { return "/" }
}

extension Expression {

    /// Case 0: Int / Int
    static func div(int lhs: Int, int rhs: Int) -> Expression {
        return .number(Div.function(lhs, rhs))
    }

    /// Case 1: Variable / Variable
    static func div(`var` lhs: Variable, `var` rhs: Variable) -> Expression {
        if lhs == rhs { return .number(1) } /* x/x => 1 */
        return .operator(Div(`var`: lhs, `var`: rhs))
    }

    /// Case 2: Variable / Int
    static func div(`var` lhs: Variable, int rhs: Int) -> Expression {
        if rhs == 0 { fatalError("CANNOT DIVIDE BY ZERO") }
        if rhs == 1 { return .variable(lhs) }
        return .operator(Div(`var`: lhs, int: rhs))
    }

    /// Case 3: Variable / Int
    /// Note: Division is NOT Commutative, thus cannot use flipped version of Case 2
    static func div(int lhs: Int, `var` rhs: Variable) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with `nil`
        return .operator(Div(int: lhs, `var`: rhs))
    }

    /// Case 4: Operator / Int
    static func div(`operator` lhs: Operator, int rhs: Int) -> Expression {
        if rhs == 0 { return .number(0) } // TODO replace with `nil`
        if rhs == 1 { return .operator(lhs) }

        if let division = lhs as? Div {
            if let numerator = division.lhs.number, let denominator = division.rhs.variable {
                // Example: 10/x
                let gcd = extendedGreatestCommonDivisor(numerator, rhs).gcd
                if gcd == 1 { // `Div(10, x) / 3` ==> `Div(10, Mul(3, x)`
                    let _multiplication = Mul(int: rhs, `var`: denominator)
                    let _division = Div(int: numerator, operator: _multiplication, wrapInParenthesis: true)
                    return .operator(_division)
                } else { // `Div(10, x) / 5` ==> `Div(2, x)`
                    return .operator(Div(int: numerator/gcd, `var`: denominator))
                }
            } else if let numerator = division.lhs.variable, let denominator = division.rhs.number {
                // Example: `Div(x, 10) / 5` ==> `Div(x, 50)`
                return .operator(Div(`var`: numerator, int: denominator * rhs))
            }
        } else if let multiplication = lhs as? Mul {
            // Multiplication is commutative, so we dont care if `8 * x` or `x * 8`, we treat them the same below
            var variable: Variable?
            var number: Int?
            if let n = multiplication.lhs.number, let v = multiplication.rhs.variable {
                variable = v
                number = n
            } else if let v = multiplication.lhs.variable, let n = multiplication.rhs.number {
                variable = v
                number = n
            }
            if let variable = variable, let number = number {
                let gcd = extendedGreatestCommonDivisor(number, rhs).gcd
                if gcd != 1 {
                    return .operator(
                        Mul(int: number/gcd, `var`: variable)
                    )
                }
            }
        }
        return .operator(Div(operator: lhs, int: rhs, wrapInParenthesis: true))
    }

    /// Case 5: Int * Expression
    static func div(int lhs: Int, exp rhs: Expression) -> Expression {
        if lhs == 0 { return .number(0) } // TODO replace with `nil`

        if let rhsNumber = rhs.number {
            print("⚠️ This should probably have been handled elsewhere???")
            return .div(int: rhsNumber, int: lhs)
        } else if let rhsVariable = rhs.variable {
            return .div(`var`: rhsVariable, int: lhs)
        } else if let `operator` = rhs.asOperator() {
            return `operator`.divided(by: lhs)
        } else { fatalError("this should not happend") }
    }
}
