//
//  GetCurrenciesRequest.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import Alamofire

struct GetCurrenciesRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/currencies"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey
        ]
    }
}
