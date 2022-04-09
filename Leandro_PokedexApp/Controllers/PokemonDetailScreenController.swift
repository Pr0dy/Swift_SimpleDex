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
    @IBOutlet weak var favoriteButton: UIButton!
    var pokemon: PokemonModel?
    var statLabels: [UILabel]?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = pokemon!.typeColor
        favoriteButtonColor(isFavorite: pokemon!.isFavorite)
        statLabels = [pokeHP,pokeAttack,pokeDefense,specialPokeAttack,specialPokeDefense,pokeSpeed]
        displayPokemonDetails()
    }
    
    func favoriteButtonColor(isFavorite: Bool){
        if isFavorite{
            favoriteButton.tintColor = UIColor.systemYellow
        } else {
            favoriteButton.tintColor = UIColor.systemGray
        }
    }
    
    func displayPokemonDetails(){
        
        pokemonName.text = pokemon!.getPokemonName()
        pokemonNumber.text = "#\(pokemon!.number)"
        
        pokemonSpriteImage.image = pokemon!.getSpriteImg(spriteURL: pokemon!.defaultSprite)
        pokemonTypeImg1.image = pokemon!.getCellPokemonTypeIcon(pokemonType: pokemon!.mainPokemonType)
        
        pokemonHeight.text = "\(pokemon!.convertHeight) m"
        pokemonWeight.text = "\(pokemon!.convertWeight) kg"

        displayStats()
  
        if let secondaryType = pokemon!.secondaryPokemonType{
           pokemonTypeImg2.image = pokemon?.getCellPokemonTypeIcon(pokemonType:secondaryType)
        }
    }
    
    func displayStats(){
        var counter = 0
        
        for label in statLabels!{
            label.text = "\(pokemon!.stats[counter].base_stat)"
            label.textColor = pokemon!.typeColor
            counter += 1
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
    
    @IBAction func favoritePressed(_ sender: Any) {        
        if pokemon!.isFavorite == false{
            pokemon!.isFavorite = true
            favoriteButtonColor(isFavorite: true)
        } else {
            pokemon!.isFavorite = false
            favoriteButtonColor(isFavorite: false)
        }
        self.tableView?.reloadData()
    }
}
