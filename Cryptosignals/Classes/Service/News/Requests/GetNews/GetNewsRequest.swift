//
//  GetNewsRequest.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import Alamofire

struct GetNewsRequest: APIRequestBody {
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/news/feed"
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
