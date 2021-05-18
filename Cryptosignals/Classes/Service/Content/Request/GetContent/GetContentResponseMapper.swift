//
//  GetContentResponseMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

final class GetContentResponseMapper {
    static func map(from response: Any) -> Content? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        let currencies = data["currencies"] as? [Int] ?? []
        let exchanges = data["exchanges"] as? [Int] ?? [] 
        
        return Content(currencies: currencies, exchanges: exchanges)
    }
}
