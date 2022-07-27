//
//  DetailsViewController.swift
//  TV Shows
//
//  Created by Infinum on 27.07.2022..
//


import Alamofire
import MBProgressHUD
import UIKit
class DetailsViewController: UIViewController, UITableViewDataSource {
    
    // MARK: Table Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    // MARK: Properties
    
    public var user: User!
    public var authInfo: AuthInfo!
    public var show: Show!
    var data: [String] = []
    
    // MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getShowInfo()
    }
    
    func setupUI(){
        self.navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    func getShowInfo(){
        tableView.dataSource = self
        AF.request(
            "https://tv-shows.infinum.academy/shows",
            method: .get,
            parameters: ["page": 1, "items": 100],
            headers: HTTPHeaders(authInfo.headers)
        )
        .validate()
        .responseDecodable(of: ReviewsResponse.self){ [weak self] dataResponse in
            guard let self = self else { return }
            switch dataResponse.result{
            case .success(let ReviewResponse):
                var reviews = ReviewResponse.reviews
                for review in reviews{
                    self.data.append(review.comment)
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                    break
            }
        }
    }
    
    // MARK: Actions

}
