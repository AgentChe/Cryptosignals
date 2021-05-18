//
//  GetExchangesResponseMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

final class GetExchangesResponseMapper {
    static func map(from response: Any) -> [Exchange] {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [[String: Any]]
        else {
            return []
        }
        
        return data.compactMap { jsonElement -> Exchange? in
            guard
                let id = jsonElement["id"] as? Int,
                let name = jsonElement["name"] as? String,
                let sort = jsonElement["sort"] as? Int,
                let preselected = jsonElement["preselected"] as? Bool
            else {
                return nil
            }
            
            return Exchange(id: id,
                            name: name,
                            sort: sort,
                            preselected: preselected)
        }
    }
}
