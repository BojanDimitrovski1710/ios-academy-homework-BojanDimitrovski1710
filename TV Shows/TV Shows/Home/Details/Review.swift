//
//  Review.swift
//  TV Shows
//
//  Created by Infinum on 27.07.2022..
//

import Foundation

struct ReviewsResponse: Codable{
    let reviews: [Review]
}

struct Review: Codable{
    let rating: Double?
    let comment: String
    let id: String
    let user: User
    
    enum CodingKeys: String, CodingKey{
        case rating
        case comment
        case id
        case user
    }
}
