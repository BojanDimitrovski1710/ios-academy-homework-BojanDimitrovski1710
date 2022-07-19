import UIKit
import MBProgressHUD
import Alamofire

struct LoginUser: Codable {
    let email: String
    let imageUrl: String?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case imageUrl = "image_url"
        case id
    }
}

struct LoginResponse: Codable {
    let user: LoginUser
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters: [String: String] = [
            "email": "filip.gulan@infinum.hr",
            "password": "infinum1"
        ]
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        AF.request(
            "https://tv-shows.infinum.academy/users/sign_in",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default
        )
        .validate() // Status code in 200 ..< 300 range
        .responseDecodable(of: LoginResponse.self) { [weak self] response in
            guard let self = self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
            switch response.result {
            case .success(let response):
                print("Success: \(response)")
            case .failure(let error):
                print("Failure: \(error)")
            }
        }
    }
}
