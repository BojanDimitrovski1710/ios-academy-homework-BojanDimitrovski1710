//
//  Demo.swift
//  Lecture_4_Demo
//
//  Created by Filip Gulan on 13.07.2022..
//

import Foundation
import Alamofire

struct User {
    let id: String
    let email: String
    let imageUrl: String?

    init?(body: [String: Any]) {
        if
            let userDict = body["user"] as? [String: Any],
            let email = userDict["email"] as? String,
            let id = userDict["id"] as? String
        {
            self.id = id
            self.email = email
            self.imageUrl = userDict["image_url"] as? String
        } else {
            return nil
        }
    }
}

func loginUserResult(email: String, password: String) {
    let parameters: [String: String] = [
        "email": email,
        "password": password
    ]
    AF
        .request(
            "https://tv-shows.infinum.academy/users/sign_in",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let body):
                print("Body: \(body)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
}

func loginUserJSON(email: String, password: String) {
    let parameters: [String: String] = [
        "email": email,
        "password": password
    ]
    AF
        .request(
            "https://tv-shows.infinum.academy/users/sign_in",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .responseJSON { response in
            switch response.result {
            case .success(let body):
                if let bodyDictionary = body as? [String: Any] {
                    let user = User(body: bodyDictionary)
                    print("email: \(user?.email)")
                } else {
                    print("Received unknown type")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
}

//struct UserResponse: Codable {
//    let user: User
//}
//
//struct User: Codable {
//    let email: String
//    let image_url: String?
//    let id: String
//}
//
//struct User: Codable {
//    let email: String
//    let imageUrl: String?
//    let id: String
//
//    enum CodingKeys: String, CodingKey {
//        case email
//        case imageUrl = "image_url"
//        case id
//    }
//}
