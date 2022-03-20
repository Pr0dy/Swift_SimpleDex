import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var pokemonManager = PokemonManager()
    var appConstants = AppStrList()
    
    let rows = ["001: X", "002: Y", "c", "d", "e", "f" , "g"]
    
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
             
            return cell
        }
    }


extension PokemonListViewController: PokemonManagerDelegate{
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
 
}

