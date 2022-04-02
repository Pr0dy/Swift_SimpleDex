//
//  PokemonDetailScreenController.swift
//  Leandro_PokedexApp
//
//  Created by leandro.banha on 31/03/2022.
//

import UIKit

class PokemonDetailScreenController: UIViewController {
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonTypeImg1: UIImageView!
    @IBOutlet weak var pokemonTypeImg2: UIImageView!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    
    var pokemon: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = pokemon!.cell_color_type
        pokemonName.text = pokemon!.getPokemonName()
        pokemonNumber.text = "#\(pokemon!.number)"
        pokemonSpriteImage.image = pokemon!.getSpriteImg(spriteURL: pokemon!.defaultSprite)
        pokemonTypeImg1.image = pokemon!.getCellPokemonTypeIcon(pokemonType: pokemon!.mainPokemonType)
        
        
        if let secondaryType = pokemon!.secondaryPokemonType{
           pokemonTypeImg2.image = pokemon!.getCellPokemonTypeIcon(pokemonType:secondaryType)
        }
    }
    
    @IBAction func pressedShinyButton(_ sender: UIButton) {
        
        if sender.currentTitle == "Shinny"{
            pokemonSpriteImage.image = pokemon!.getSpriteImg(spriteURL: pokemon!.defaultSprite)
            sender.setTitle("Normal", for: .normal)
        } else {
            pokemonSpriteImage.image = pokemon!.getSpriteImg(spriteURL: pokemon!.shinySprite)
            sender.setTitle("Shinny", for: .normal)
        }
        
        
    }
    
}
