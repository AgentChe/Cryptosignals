//
//  GetExchangesRequest.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 18.05.2021.
//

import Alamofire

struct GetExchangesRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/exchanges"
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
