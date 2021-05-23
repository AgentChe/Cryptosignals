//
//  GetOpenedSignalsRequest.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 22.05.2021.
//

import Alamofire

struct GetOpenedSignalsRequest: APIRequestBody {
    let userToken: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/signals/open"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
    }
}
