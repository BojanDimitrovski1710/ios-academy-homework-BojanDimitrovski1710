//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Infinum on 27.07.2022..
//

import UIKit
import Alamofire
import MBProgressHUD
import Kingfisher
final class ShowsViewController: UIViewController {
    
    // MARK: - Properties
    
    public var user: User!
    public var authInfo: AuthInfo!
    var data: [Show] = []
    private var notificationToken: NSObjectProtocol?
    
    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        getShows()
        tableView.dataSource = self
        tableView.delegate = self
        let profileDetailsItem = UIBarButtonItem(
                  image: UIImage(named: "ic-profile"),
                  style: .plain,
                  target: self,
                  action: #selector(profileDetailsActionHandler)
                )
        profileDetailsItem.tintColor = UIColor.purple
        navigationItem.rightBarButtonItem = profileDetailsItem
        self.navigationItem.title = "Shows"
    }
    
    func setupNotifications(){
        NotificationCenter
            .default
            .addObserver(forName: Notification.Name(rawValue: "didLogout"), object: nil, queue: nil) { notification in
                let newStoryboard = UIStoryboard(name: "Login", bundle: nil)
                let loginViewController = newStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.setViewControllers(
                    [loginViewController], animated: true)
            }
    }
    
    @objc func profileDetailsActionHandler(){
        let NewStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let ProfileViewController = NewStoryboard.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        let navigationController = UINavigationController(rootViewController: ProfileViewController)
        ProfileViewController.authInfo = self.authInfo
        present(navigationController, animated: true)
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
                for show in shows{
                    self.data.append(show)
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
        DetailsViewController.show = data[indexPath.row]
        self.navigationController?.pushViewController(DetailsViewController, animated: true)
        
    }
}

extension ShowsViewController: UITableViewDataSource{
    // MARK: - Table Functions
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "proto1", for: indexPath) as? ShowsTableViewCell
        else{
            print("Something Went Wrong")
            return UITableViewCell()
        }
        cell.showName.text = data[indexPath.row].title
        let url = URL(string: data[indexPath.row].image_url!)
        cell.showImage.kf.setImage(with: url, placeholder: UIImage(named: "ic-show-placeholder-vertical"))
        return cell
    }
}
