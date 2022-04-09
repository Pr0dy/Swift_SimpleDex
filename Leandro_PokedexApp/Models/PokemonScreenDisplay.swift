//
//  PokemonScreenDisplay.swift
//  Leandro_PokedexApp
//
//  Created by leandro.banha on 05/04/2022.
//

import Foundation
import UIKit

struct PokemonScreenDisplay{
    
    func displayPokemonInTableViewCell(pokemon: PokemonModel, tableViewCell: PokemonCell?){
        tableViewCell?.pokemonName.text = pokemon.getPokemonName()
        tableViewCell?.pokemonNumber.text = "#\(pokemon.number)"
        tableViewCell?.pokemonImage.image = pokemon.getSpriteImg(spriteURL: pokemon.defaultSprite)
        tableViewCell?.backgroundColor = pokemon.typeColor
        tableViewCell?.pokemonTypeImg1.image = pokemon.getCellPokemonTypeIcon(pokemonType: pokemon.mainPokemonType)
        tableViewCell?.pokemonTypeImg2.image = nil
        
        if let secondaryType = pokemon.secondaryPokemonType{
            tableViewCell?.pokemonTypeImg2.image = pokemon.getCellPokemonTypeIcon(pokemonType:secondaryType)
        }
    }
}
