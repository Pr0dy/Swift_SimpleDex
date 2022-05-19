//
//  LocalFavPokemon+CoreDataProperties.swift
//  Leandro_PokedexApp
//
//  Created by leandro.banha on 19/05/2022.
//
//

import Foundation
import CoreData


extension LocalFavPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalFavPokemon> {
        return NSFetchRequest<LocalFavPokemon>(entityName: "FavoritePokemon")
    }

    @NSManaged public var favoritePokemon: [Int]?

}

extension LocalFavPokemon : Identifiable {

}
