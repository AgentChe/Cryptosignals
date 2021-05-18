//
//  SaveSelectedCurrenciesRequest.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import Alamofire

struct SaveSelectedCurrenciesRequest: APIRequestBody {
    let userToken: String
    let ids: [Int]
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/users/set"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "currencies": ids
        ]
    }
}
