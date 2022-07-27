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
    let rating: Int
    let comment: String
    let id: String
    
    enum CodingKeys: String, CodingKey{
        case rating
        case comment
        case id
    }
}
