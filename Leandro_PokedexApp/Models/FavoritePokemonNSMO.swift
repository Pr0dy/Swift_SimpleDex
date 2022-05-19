//
//  FavoritePokemonNSMO.swift
//  Leandro_PokedexApp
//
//  Created by leandro.banha on 19/05/2022.
//

import Foundation
import CoreData

class FavoritePokemonNSMO: NSManagedObject{
    @NSManaged var favoritePokemon: [PokemonModel]
}
