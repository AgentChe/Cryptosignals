//
//  GetPostDetails.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

import Alamofire

struct GetPostDetailsRequest: APIRequestBody {
    let id: Int
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/news/post"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "post_id": id
        ]
    }
}
