//
//  GetCurrenciesResponseMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

final class GetCurrenciesResponseMapper {
    static func map(from response: Any) -> [Currency] {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let array = data["currencies"] as? [[String: Any]]
        else {
            return []
        }
        
        return array.compactMap { jsonElement -> Currency? in
            guard
                let id = jsonElement["id"] as? Int,
                let name = jsonElement["name"] as? String,
                let code = jsonElement["code"] as? String,
                let sort = jsonElement["sort"] as? Int,
                let preselected = jsonElement["preselected"] as? Bool
            else {
                return nil
            }
            
            return Currency(id: id,
                            name: name,
                            code: code,
                            sort: sort,
                            preselected: preselected)
        }
    }
}
