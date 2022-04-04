import UIKit
import CoreData

class PokemonListViewController: UIViewController  {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var pokemonManager = PokemonManager()
    var appConstants = AppConstants()
    var cellToDisplay: PokemonCell?
    var pokemonDictList = [Int:PokemonModel]()
    var filteredPokemonList: [Int:PokemonModel]?
    var pokemonDetails: PokemonModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pokemonManager.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: appConstants.reusableCellIdentifier, bundle: nil), forCellReuseIdentifier: appConstants.reusableCellIdentifier)
        filteredPokemonList = pokemonDictList
        performPokeRequerst(lastLoadedPokemon: 1)
    }
    
    func performPokeRequerst(lastLoadedPokemon: Int) {
        let lastPokemonToLoad = lastLoadedPokemon + appConstants.pokemonScrollingIncrement
        for pokemonIndex in lastLoadedPokemon...lastPokemonToLoad{
            if pokemonIndex <= appConstants.totalPokemons{
                pokemonManager.fetchPokemon(number: pokemonIndex)
            }
        }
    }
}
    extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource
{
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            pokemonDetails = pokemonDictList[indexPath.row+1]
            self.performSegue(withIdentifier: appConstants.detailScreenSegueIdentifier, sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == appConstants.detailScreenSegueIdentifier{
                let nextVC = segue.destination as! PokemonDetailScreenController
                nextVC.pokemon = pokemonDetails
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredPokemonList!.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(appConstants.cellHeight)
        }
         
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
             cellToDisplay = tableView.dequeueReusableCell(withIdentifier: appConstants.reusableCellIdentifier, for: indexPath) as? PokemonCell

            cellToDisplay?.selectionStyle = .none
            
             if let pokemon = filteredPokemonList![indexPath.row+1]{
                 cellToDisplay?.pokemonName.text = pokemon.getPokemonName()
                 cellToDisplay?.pokemonNumber.text = "#\(pokemon.number)"
                 cellToDisplay?.pokemonImage.image = pokemon.getSpriteImg(spriteURL: pokemon.defaultSprite)
                 cellToDisplay?.backgroundColor = pokemon.cell_color_type
                 cellToDisplay?.pokemonTypeImg1.image = pokemon.getCellPokemonTypeIcon(pokemonType: pokemon.mainPokemonType)
                 cellToDisplay?.pokemonTypeImg2.image = nil
                 
                 if let secondaryType = pokemon.secondaryPokemonType{
                     cellToDisplay?.pokemonTypeImg2.image = pokemon.getCellPokemonTypeIcon(pokemonType:secondaryType)
                 }
             }
                 
            if indexPath.row+1 == (filteredPokemonList!.count) && indexPath.row+1 < appConstants.totalPokemons{
                 performPokeRequerst(lastLoadedPokemon: indexPath.row+1)
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
        var counter = 1
        
        if searchText == ""{
            filteredPokemonList = pokemonDictList
        }
        
        else{
            if CharacterSet(charactersIn: searchText).isSubset(of: CharacterSet.decimalDigits){
                searchResults[1] = pokemonDictList[Int(searchText)!]
            }
            
            else{
                for entry in Array(pokemonDictList.keys).sorted(by:<){
                    if pokemonDictList[entry]!.name.lowercased().contains(searchText.lowercased())
                        || pokemonDictList[entry]!.mainPokemonType.lowercased() == searchText.lowercased()
                        || pokemonDictList[entry]!.secondaryPokemonType?.lowercased() == searchText.lowercased(){
                        searchResults[counter] = pokemonDictList[entry]
                        counter+=1
                    }
                }
            }
            
             filteredPokemonList = searchResults
        }
        self.tableView.reloadData()
    }
}


