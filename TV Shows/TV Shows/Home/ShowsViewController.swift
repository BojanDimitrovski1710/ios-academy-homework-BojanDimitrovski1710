//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Infinum on 27.07.2022..
//

import UIKit
import Alamofire
import MBProgressHUD
final class ShowsViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    // MARK: - Properties
    
    public var user: User!
    public var authInfo: AuthInfo!
    var data: [String] = []
    private var shows: [Show]!
    
    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getShows()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getShows(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AF.request(
            "https://tv-shows.infinum.academy/shows",
            method: .get,
            parameters: ["page": 1, "items": 100],
            headers: HTTPHeaders(authInfo.headers)
        )
        .validate()
        .responseDecodable(of: ShowResponse.self){ [weak self] dataResponse in
            guard let self = self else { return }
            switch dataResponse.result{
            case .success(let ShowResponse):
                let shows = ShowResponse.shows
                self.shows = shows
                for show in shows{
                    self.data.append(show.title)
                    self.tableView.reloadData()
                }
                break
            case .failure(_):
                    break
            }
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
        }
    }
    
    // MARK: - Actions
    
    
}

extension ShowsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let NewStoryboard = UIStoryboard(name: "Details", bundle: nil)
        let DetailsViewController = NewStoryboard.instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        DetailsViewController.user = user
        DetailsViewController.authInfo = authInfo
        DetailsViewController.show = shows[indexPath.row]
        self.navigationController?.pushViewController(DetailsViewController, animated: true)
        
    }
}
