//
//  DetailViewController.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 29.10.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var loginUserLabel: UILabel!
    @IBOutlet weak var locationUserLabel: UILabel!
    @IBOutlet weak var followersUserLabel: UILabel!
    @IBOutlet weak var nameRepositoriesLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var repositories: ItemsResults?
    
    var service: ServiceRequest?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service = ServiceRequest()
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showActivityIndicator(show: true)
        
        guard let userName = repositories?.owner?.login else { return }
        
        service?.getSearchUser(searchText: userName, completion: { [weak self] result in
            DispatchQueue.main.async {
                self?.showActivityIndicator(show: false)
                self?.nameUserLabel.text = result.name
                self?.loginUserLabel.text = result.login
                self?.locationUserLabel.text = result.location
                self?.followersUserLabel.text = "\(result.followers) followers . \(result.following) following"
                self?.locationUserLabel.text = result.location
                
                self?.nameRepositoriesLabel.text = self?.repositories?.fullName
                self?.descriptionTextView.text = self?.repositories?.description
                
                guard let imageUrl = result.avatarUrl else { return }
                self?.profileImage.loadImageUsingCacheWithUrlString(imageUrl) { _ in }
            }
        })
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
