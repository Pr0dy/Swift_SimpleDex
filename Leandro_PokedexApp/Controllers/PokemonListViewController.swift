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
    }
    
}
    
    extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource
{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return appConstants.totalPokemons
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
             cellToDisplay = tableView.dequeueReusableCell(withIdentifier: appConstants.reusableCellIdentifier, for: indexPath) as? PokemonCell
             
             if pokemonDictList.keys.contains(indexPath.row+1) == false{
                 pokemonManager.fetchPokemon(number:  indexPath.row+1)
             } else {
                 cellToDisplay?.pokemonName.text = pokemonDictList[indexPath.row+1]?.name
                 cellToDisplay?.pokemonNumber.text = "#\(String(indexPath.row+1))"
             }
            
             
            return cellToDisplay!
        }
    }


extension PokemonListViewController: PokemonManagerDelegate{
    
    func didUpdatePokemon(pokemon: PokemonModel) {
        DispatchQueue.main.async {
            self.cellToDisplay?.pokemonName.text = pokemon.getPokemonName()
            self.cellToDisplay?.pokemonNumber.text = "#\(String(pokemon.number))"
            self.pokemonDictList[pokemon.number] = pokemon
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
 
}

