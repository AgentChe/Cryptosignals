//
//  GetPostDetailsResponseMapper.swift
//  Cryptosignals
//
//  Created by Andrey Chernyshev on 20.05.2021.
//

final class GetPostDetailsResponseMapper {
    static func map(from response: Any) -> PostDetails? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        let headerJSON = data["post"] as? [String: Any] ?? [:]
        let postsArray = data["related"] as? [[String: Any]] ?? []
        
        var header: PostHeader?
        if
            let title = headerJSON["title"] as? String,
            let imageUrl = headerJSON["image"] as? String,
            let html = headerJSON["html"] as? String {
            header = PostHeader(title: title,
                                imageUrl: imageUrl,
                                html: html)
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
        
        return PostDetails(header: header, posts: posts)
    }
}
