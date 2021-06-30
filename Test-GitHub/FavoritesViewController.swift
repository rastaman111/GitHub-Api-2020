//
//  FavoritesViewController.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 29.10.2020.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    var listItems = [FavoritesList]()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"

        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadDocumentsIsEmpty()
        
    }
    
    func reloadDocumentsIsEmpty() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.listItems = DataManager.getList()
            
            if self.listItems.count == 0 {
                self.tableView.setEmptyView(title: "Пока пусто :(", message: "Добавте в избранное", messageImage: #imageLiteral(resourceName: "github"))
            }else{
                self.tableView.restore()
                
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell

        let items = listItems[indexPath.row]
        
        cell.starLabel.text = items.stars
        cell.languageLabel.text = items.language
        cell.titleLabel.text = items.repositories
        cell.detailLabel.text = items.descriptions
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
