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
        pokemonNumber.text = "\(pokemon!.number)"
        pokemonSpriteImage.image = pokemon!.defaultSpritImage
        pokemonTypeImg1.image = pokemon!.getCellPokemonTypeIcon(pokemonType: pokemon!.mainPokemonType)
        
        
        if let secondaryType = pokemon!.secondaryPokemonType{
           pokemonTypeImg2.image = pokemon!.getCellPokemonTypeIcon(pokemonType:secondaryType)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
