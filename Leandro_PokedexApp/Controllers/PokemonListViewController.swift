import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var pokemonManager = PokemonManager()
    var appConstants = AppStrList()
    var PokemonData: PokemonModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pokemonManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
}
    
    extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource
{
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
             let cell = tableView.dequeueReusableCell(withIdentifier: appConstants.reusableCellIdentifier, for: indexPath)
            
             pokemonManager.fetchPokemon(number:  indexPath.row+1)
             
             cell.textLabel?.text = PokemonData?.name
             
            return cell
        }
    }


extension PokemonListViewController: PokemonManagerDelegate{
    
    func didUpdatePokemon(pokemon: PokemonModel) {
        PokemonData = pokemon
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
 
}

