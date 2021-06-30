//
//  ViewController.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 28.10.2020.
//

import UIKit

class ViewController: UITableViewController {
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var service: ServiceRequest?
    
    private var repositories: [ItemsResults]?
    
    var errors = String()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub Search"
        
        service = ServiceRequest()
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
        view.addSubview(activityIndicator)
        
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableView.register(UINib(nibName: "ErrorCell", bundle: nil), forCellReuseIdentifier: "ErrorCell")
        tableView.setEmptyView(title: "Пока пусто :(", message: "Введите в поиске ", messageImage: #imageLiteral(resourceName: "github"))
        
        // Setup the Search Controller
        searchController.searchBar.delegate = self
        searchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        searchController.searchBar.placeholder = "Поиск..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
// MARK: UITableViewDelegate and DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if errors != "" {
           return 1
        }
        return repositories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        if errors != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ErrorCell", for: indexPath) as! ErrorCell
            cell.errorLabel.text = errors
            return cell
        } else {
            guard let items = repositories?[indexPath.row] else { return cell }
            
            cell.starLabel.text = items.stargazersCount?.description
            cell.languageLabel.text = items.language
            cell.titleLabel.text = items.fullName
            cell.detailLabel.text = items.description
            if let url = items.owner?.avatarUrl {
                cell.avatarImageView.loadImageUsingCacheWithUrlString(url) { _ in }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if errors == "" {
            guard let items = repositories?[indexPath.row] else { return }
            
            let popupContentController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            popupContentController.repositories = items
            
            navigationController?.pushViewController(popupContentController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearch Delegate

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        showActivityIndicator(show: true)
        
        let stringFixed = text.replacingOccurrences(of: " ", with: "+")
        
        service?.getSearchList(searchText: stringFixed, completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.repositories = response.items
                
                DispatchQueue.main.async {
                    self?.showActivityIndicator(show: false)
                    self?.tableView.restore()
                    self?.tableView.reloadData()
                    self?.searchController.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
