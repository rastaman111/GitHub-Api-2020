//
//  DataManager+CoreData.swift
//  Test-GitHub
//
//  Created by Александр Сибирцев on 29.10.2020.
//

import Foundation
import CoreData

class DataManager {
    public class func getList() -> [FavoritesList] {
        let fetchRequest: NSFetchRequest<FavoritesList> = FavoritesList.fetchRequest()
        
        do {
            let result = try PersistenceServce.contex.fetch(fetchRequest)
            
            return result
        } catch {
            print("Data didn not Retrieve")
        }
        
        return []
    }
    
    public class func insertItemList(descriptions: String, language: String, repositories: String, stars: String) {
        var listItems = getList()
        
        let item = FavoritesList(context: PersistenceServce.contex)
        item.descriptions = descriptions
        item.language = language
        item.repositories = repositories
        item.stars = stars
        
        do {
            try PersistenceServce.contex.save()
            listItems.append(item)
            print("Succes Save")
            
        } catch {
            print("Didn't Save")
        }
    }
    
}
