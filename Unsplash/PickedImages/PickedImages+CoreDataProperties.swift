//
//  PickedImages+CoreDataProperties.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/8/22.
//
//

import Foundation
import CoreData


extension PickedImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PickedImages> {
        return NSFetchRequest<PickedImages>(entityName: "PickedImages")
    }

    @NSManaged public var id: String?
    @NSManaged public var authorName: String?
    @NSManaged public var imageURL: String?
}

extension PickedImages : Identifiable {

}
