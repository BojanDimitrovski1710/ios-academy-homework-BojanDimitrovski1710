//
//  DetailsViewController.swift
//  TV Shows
//
//  Created by Infinum on 27.07.2022..
//


import Alamofire
import MBProgressHUD
import UIKit
class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Table Functions
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard var cell = tableView.dequeueReusableCell(withIdentifier: "proto1", for: indexPath) as? ShowInfoTableViewCell
            else{
                print("Something Went Wrong")
                return UITableViewCell()
            }
            cell.showTitle.text = self.show.title
            cell.showDescription.text = self.show.description
            cell.reviewDetails.text = String(data.count) + " REVIEWS, " + String(getRatingAverage()) + " AVERAGE"
            return cell
        }
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "proto2", for: indexPath) as? ReviewTableViewCell
        else{
            return UITableViewCell()
        }
        let review = data[indexPath.row]
        cell.reviewComment.text = review.comment
        cell.userEmail.text = review.user.email
        return cell
    }
    
    // MARK: Properties
    
    public var user: User!
    public var authInfo: AuthInfo!
    public var show: Show!
    var data: [Review] = []
    
    // MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getShowInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func getRatingAverage() -> Double{
        var score = 0.00
        for review in data{
            score += review.rating!
        }
        score /= Double(data.count)
        return score
    }
    
    func setupUI(){
        self.navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    func getShowInfo(){
        tableView.dataSource = self
        AF.request(
            "https://tv-shows.infinum.academy/shows/" + show.id + "/reviews",
            method: .get,
            headers: HTTPHeaders(authInfo.headers)
        )
        .validate()
        .responseDecodable(of: ReviewsResponse.self){ [weak self] dataResponse in
            guard let self = self else { return }
            switch dataResponse.result{
            case .success(let ReviewResponse):
                let reviews = ReviewResponse.reviews
                for review in reviews{
                    self.data.append(review)
                    self.tableView.reloadData()
                }
                break
            case .failure(_):

                    break
            }
        }
    }
    
    // MARK: Actions
    @IBAction func presentWriteReview(_ sender: Any) {
        let NewStoryboard = UIStoryboard(name: "WriteReview", bundle: nil)
        let WriteReviewViewController = NewStoryboard.instantiateViewController(withIdentifier: "WriteReview") as! WriteReviewViewController
        WriteReviewViewController.user = self.user
        WriteReviewViewController.show = self.show
        WriteReviewViewController.authInfo = self.authInfo
        let navigationController = UINavigationController(rootViewController: WriteReviewViewController)
        present(navigationController, animated: true)
    }
    
}
