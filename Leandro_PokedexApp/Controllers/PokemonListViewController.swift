import UIKit
import CoreData

class PokemonListViewController: UIViewController  {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var pokemonManager = PokemonManager()
    var appConstants = AppStrList()
    var cellToDisplay: PokemonCell?
    var pokemonDictList = [Int:PokemonModel]()
    var filteredPokemonList: [Int:PokemonModel]?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pokemonManager.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: appConstants.reusableCellIdentifier, bundle: nil), forCellReuseIdentifier: appConstants.reusableCellIdentifier)
        
            filteredPokemonList = pokemonDictList
                
        for i in 1...appConstants.totalPokemons{
            pokemonManager.fetchPokemon(number: i)
        }
    }
    
}
    extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource
{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredPokemonList!.count   
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
         
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
             cellToDisplay = tableView.dequeueReusableCell(withIdentifier: appConstants.reusableCellIdentifier, for: indexPath) as? PokemonCell
             
             if let pokemon = filteredPokemonList![indexPath.row+1]{
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
            self.filteredPokemonList = self.pokemonDictList
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


extension PokemonListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
        var searchResults = [Int:PokemonModel]()
        
        if searchText == ""{
            filteredPokemonList = pokemonDictList
        }
        
        else{
            if CharacterSet(charactersIn: searchText).isSubset(of: CharacterSet.decimalDigits){
                searchResults[1] = pokemonDictList[Int(searchText)!]
            }
            
            filteredPokemonList = searchResults
        }
        
        
        self.tableView.reloadData()
     
    }
}


