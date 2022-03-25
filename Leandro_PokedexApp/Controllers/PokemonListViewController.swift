import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var pokemonManager = PokemonManager()
    var appConstants = AppStrList()
    var cellToDisplay: PokemonCell?
    var pokemonDictList = [Int:PokemonModel]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pokemonManager.delegate = self
        tableView.register(UINib(nibName: appConstants.reusableCellIdentifier, bundle: nil), forCellReuseIdentifier: appConstants.reusableCellIdentifier)
        
        for i in 1...appConstants.totalPokemons{
            pokemonManager.fetchPokemon(number: i)
        }
    }
    
}
    extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource
{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return appConstants.totalPokemons
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
         
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
             cellToDisplay = tableView.dequeueReusableCell(withIdentifier: appConstants.reusableCellIdentifier, for: indexPath) as? PokemonCell
             
             if let pokemon = pokemonDictList[indexPath.row+1]{
                 cellToDisplay?.pokemonName.text = pokemon.getPokemonName()
                 cellToDisplay?.pokemonNumber.text = "#\(pokemon.number)"
                 cellToDisplay?.pokemonImage.image = pokemon.defaultSpritImage
                 cellToDisplay?.backgroundColor = pokemon.cell_color_type
                 cellToDisplay?.pokemonTypeImg1.image = pokemon.getCellPokemonTypeIcon(pokemonType: pokemon.mainPokemonType)
                 cellToDisplay?.pokemonTypeImg2.image = nil
                 
                 if let secondaryType = pokemon.secondaryPokemonType{
                     cellToDisplay?.pokemonTypeImg2.image = pokemon.getCellPokemonTypeIcon(pokemonType:secondaryType)
                 }
             }
             
            return cellToDisplay!
        }
    }


extension PokemonListViewController: PokemonManagerDelegate{
    
    func didUpdatePokemon(pokemon: PokemonModel) {
        DispatchQueue.main.async {
            self.pokemonDictList[pokemon.number] = pokemon
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
