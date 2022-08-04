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

struct ReviewResponse: Codable{
    let id: String
    let comment: String
    let rating: Int
    let show_id: Int
    let user: User
}

struct ReviewRequest: Codable{
    let rating: Int
    let comment: String
    let show_id: Int
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
