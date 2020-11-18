//
//  ViewController.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 28.10.2020.
//

import UIKit

class ViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var service: ServiceRequest?
    
    var repositories: [ItemsResults]?
    
    var errors = String()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub Search"
        
        service = ServiceRequest()
        
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableView.register(UINib(nibName: "ErrorCell", bundle: nil), forCellReuseIdentifier: "ErrorCell")
        
        tableView.setEmptyView(title: "Пока пусто :(", message: "Введите в поиске ", messageImage: #imageLiteral(resourceName: "github"))
        
        // Setup the Search Controller
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ReachabilityManager.isUnreachable { _ in
            DispatchQueue.main.async {
                let viewControllerMessageList = self.storyboard?.instantiateViewController(withIdentifier: "OfflineViewController") as! OfflineViewController
                self.navigationController?.pushViewController(viewControllerMessageList, animated: true)
            }
        }
        
        ReachabilityManager.isReachable { _ in
            //self.checkExcursionList()
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
            
            cell.starLabel.text = items.stargazers_count?.description
            cell.languageLabel.text = items.language
            cell.titleLabel.text = items.full_name
            cell.detailLabel.text = items.description
            
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UISearch Delegate
extension ViewController: UISearchControllerDelegate {
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        let stringFixed = searchText.replacingOccurrences(of: " ", with: "+")

        service?.getSearchList(searchText: stringFixed, completion: { result in
            if result.message != nil {
                self.errors = result.message ?? ""
            } else {
                self.repositories = result.items
            }
            
            DispatchQueue.main.async {
                self.tableView.restore()
                self.tableView.reloadData()
                self.searchController.isActive = false
            }
        })
    }
}

