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
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return appConstants.totalPokemons
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
             cellToDisplay = tableView.dequeueReusableCell(withIdentifier: appConstants.reusableCellIdentifier, for: indexPath) as? PokemonCell
             
             if let pokemonName = pokemonDictList[indexPath.row+1]?.getPokemonName(){
                 cellToDisplay?.pokemonName.text = pokemonName
             }
             else{
                 cellToDisplay?.pokemonName.text = "Not loaded"
             }
             cellToDisplay?.pokemonNumber.text = "#\(String(indexPath.row+1))"
               
             
            return cellToDisplay!
        }
    }


extension PokemonListViewController: PokemonManagerDelegate{
    
    func didUpdatePokemon(pokemon: PokemonModel) {
        DispatchQueue.main.async {
            self.pokemonDictList[pokemon.number] = pokemon
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
 
}

