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
    @IBOutlet weak var pokeHP: UILabel!
    @IBOutlet weak var pokeDefense: UILabel!
    @IBOutlet weak var pokeAttack: UILabel!
    @IBOutlet weak var specialPokeAttack: UILabel!
    @IBOutlet weak var specialPokeDefense: UILabel!
    @IBOutlet weak var pokeSpeed: UILabel!
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    var pokemon: PokemonModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = pokemon!.cell_color_type
        pokemonName.text = pokemon!.getPokemonName()
        pokemonNumber.text = "#\(pokemon!.number)"
        pokemonSpriteImage.image = pokemon!.getSpriteImg(spriteURL: pokemon!.defaultSprite)
        pokemonTypeImg1.image = pokemon!.getCellPokemonTypeIcon(pokemonType: pokemon!.mainPokemonType)
        pokemonHeight.text = "\(pokemon!.convertHeight) m"
        pokemonWeight.text = "\(pokemon!.convertWeight) kg"
        pokeHP.text = "\(pokemon!.stats[0].base_stat)"
        pokeAttack.text = "\(pokemon!.stats[1].base_stat)"
        pokeDefense.text = "\(pokemon!.stats[2].base_stat)"
        specialPokeAttack.text = "\(pokemon!.stats[3].base_stat)"
        specialPokeDefense.text = "\(pokemon!.stats[4].base_stat)"
        pokeSpeed.text = "\(pokemon!.stats[5].base_stat)"
        
        if let secondaryType = pokemon!.secondaryPokemonType{
           pokemonTypeImg2.image = pokemon?.getCellPokemonTypeIcon(pokemonType:secondaryType)
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
