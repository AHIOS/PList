//
//  Result.swift
//  PList
//
//  Created by Giuseppe Valenti on 29/12/20.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
