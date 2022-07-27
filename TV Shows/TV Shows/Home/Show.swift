//
//  Show.swift
//  TV Shows
//
//  Created by Infinum on 27.07.2022..
//

import Foundation
struct Show: Decodable{
    let id: String
    let title: String
    let average_rating: Int
    let description: String
    let no_of_reviews: Int
    let image_url: String
}

struct ShowResponse: Decodable{
    let shows: [Show]
}
