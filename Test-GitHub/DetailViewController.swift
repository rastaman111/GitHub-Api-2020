//
//  DetailViewController.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 29.10.2020.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var nameRepositoriesLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var addFavoritesButton: UIButton! {
        didSet {
            addFavoritesButton.isHidden = true
        }
    }
    
    var repositories: ItemsResults?
    
    var service: ServiceRequest?
    
    var listItems = [FavoritesList]()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service = ServiceRequest()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let userName = repositories?.owner?.login else { return }
        
        service?.getSearchUser(searchText: userName, completion: { result in
            DispatchQueue.main.async {
                if result.message != nil {
                    self.nameUserLabel.text = result.message
                    self.nameRepositoriesLabel.text = ""
                    self.descriptionTextView.text = ""
                    self.addFavoritesButton.isHidden = true
                } else {
                    guard let imageUrl = result.avatar_url else { return }
                    
                    self.profileImage.kf.setImage(with: URL(string: imageUrl))
                    self.nameUserLabel.text = result.name
                    self.nameRepositoriesLabel.text = self.repositories?.full_name
                    self.descriptionTextView.text = self.repositories?.description
                   
                    self.listItems = DataManager.getList()
                    
                    if let _ = self.listItems.firstIndex(where: { $0.repositories == self.repositories?.full_name }) {
                        self.addFavoritesButton.isHidden = true
                    } else {
                        self.addFavoritesButton.isHidden = false
                    }
                }
            }
        })
    }
    
    @IBAction func AddFavoritRepositories(_ sender: UIButton) {
        
        DataManager.insertItemList(descriptions: repositories!.description!, language: repositories!.language!, repositories: repositories!.full_name!, stars: repositories!.stargazers_count!.description)
        
        addFavoritesButton.isHidden = true
    }
}
