//
//  GetNewsResponseMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

final class GetNewsResponseMapper {
    static func map(from response: Any) -> News? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        let featuresArray = data["featured"] as? [[String: Any]] ?? []
        let postsArray = data["posts"] as? [[String: Any]] ?? []
        
        let features = featuresArray.compactMap { featureJSON -> Feature? in
            guard
                let id = featureJSON["id"] as? Int,
                let title = featureJSON["title"] as? String,
                let description = featureJSON["description"] as? String,
                let imageUrl = featureJSON["img_url"] as? String
            else {
                return nil
            }
            
            return Feature(id: id,
                           title: title,
                           description: description,
                           imageUrl: imageUrl)
        }
        
        let posts = postsArray.compactMap { postJSON -> Post? in
            guard
                let id = postJSON["id"] as? Int,
                let title = postJSON["title"] as? String,
                let time = postJSON["time"] as? String,
                let imageUrl = postJSON["img_url"] as? String
            else {
                return nil
            }
            
            return Post(id: id,
                        title: title,
                        time: time,
                        imageUrl: imageUrl)
        }
        
        return News(features: features, posts: posts)
    }
}
