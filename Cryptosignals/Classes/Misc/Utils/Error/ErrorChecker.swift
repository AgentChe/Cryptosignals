//
//  ErrorChecker.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

final class ErrorChecker {
    static func withoutError(in response: Any) -> Bool {
        guard
            let json = response as? [String: Any],
            let code = json["_code"] as? Int
        else {
            return false
        }
        
        return code == 200
    }
}
