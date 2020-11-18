//
//  FavoritesList+CoreDataProperties.swift
//  
//
//  Created by Александр Сибирцев on 29.10.2020.
//
//

import Foundation
import CoreData


extension FavoritesList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesList> {
        return NSFetchRequest<FavoritesList>(entityName: "FavoritesList")
    }

    @NSManaged public var language: String?
    @NSManaged public var repositories: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var stars: String?

}
