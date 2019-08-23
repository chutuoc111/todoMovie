//
//  APIError.swift
//  TodoMovie
//
//  Created by dang.nguyen.vu on 4/24/18.
//

import Foundation

public enum APIError: Error, LocalizedError {
    
    case unknow
    
    public var value: String {
        return String(describing: self)
    }
    
    public var errorDescription: String? {
        return nil
    }
}

extension APIError: Equatable {
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.value == rhs.value
    }
}
