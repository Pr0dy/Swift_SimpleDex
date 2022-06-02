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
    var searching = false
    var isFavoriteListDisplayed = false
    var dataContext = (UIApplication.shared.delegate as!    AppDelegate).persistentContainer.viewContext
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pokemonManager.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: appConstants.reusableCellIdentifier, bundle: nil), forCellReuseIdentifier: appConstants.reusableCellIdentifier)
        
        filteredPokemonList = pokemonDictList
        performPokeRequest(lastLoadedPokemon: 1)
    }
    
    func performPokeRequest(lastLoadedPokemon: Int) {
        let lastPokemonToLoad = lastLoadedPokemon + appConstants.pokemonScrollingIncrement
        for pokemonIndex in lastLoadedPokemon...lastPokemonToLoad{
            if pokemonIndex <= appConstants.totalPokemons{
                pokemonManager.performRequest(number:  pokemonIndex)
            }
        }
    }
    
    // MARK: - Favorite Search Methods
    
    @IBAction func pressedFavoritePokemonButton(_ sender: UIButton) {

        if isFavoriteListDisplayed == false{
            isFavoriteListDisplayed = true
            searching = true
            var count = 1
            var searchResults = [Int:PokemonModel]()
            
            do{
                let favorites = try dataContext.fetch(FavoritePokemon.fetchRequest())
            
                for entry in favorites.sorted(by: {$0.number < $1.number}){
                    if pokemonDictList[Int(entry.number)] != nil{
                        searchResults[count] = pokemonDictList[Int(entry.number)]
                        pokemonDictList[Int(entry.number)]?.isFavorite = true
                        count+=1
            }
                }
                
            } catch {
                print(error)
            }
            
            filteredPokemonList = searchResults
        }
        
        else {
            filteredPokemonList = pokemonDictList
            isFavoriteListDisplayed = false
            searching = false
        }
        
        self.tableView.reloadData()
       
    }

}
// MARK: - Table view methods
    extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource
{
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            pokemonDetails = filteredPokemonList?[indexPath.row+1]
            self.performSegue(withIdentifier: appConstants.detailScreenSegueIdentifier, sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == appConstants.detailScreenSegueIdentifier{
                let nextVC = segue.destination as! PokemonDetailScreenController
                nextVC.pokemon = pokemonDetails
                nextVC.tableView = self.tableView
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredPokemonList!.count
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(appConstants.cellHeight)
        }
         
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            do{
            let favorites = try dataContext.fetch(FavoritePokemon.fetchRequest())
                cellToDisplay = tableView.dequeueReusableCell(withIdentifier: appConstants.reusableCellIdentifier, for: indexPath) as? PokemonCell

                cellToDisplay?.selectionStyle = .none
                cellToDisplay?.starIconCell.image = nil
                
                 if let pokemon = filteredPokemonList![indexPath.row+1]{
                     displayPokemonInTableViewCell(pokemon: pokemon, tableViewCell: cellToDisplay)
                     
                     for entry in favorites{
                         if entry.number == pokemon.number{
                             pokemon.isFavorite = true
                         }
                     }
                     
                     if pokemon.isFavorite{
                         cellToDisplay?.starIconCell.image = UIImage(named: appConstants.startIconLabel)
                     }
                 }
                 
                     
                if indexPath.row+1 == (filteredPokemonList!.count) && indexPath.row+1 < appConstants.totalPokemons && searching == false{
                     performPokeRequest(lastLoadedPokemon: indexPath.row+1)
                }
                
                
            } catch {
                print(error)
            }
            
                
            return cellToDisplay!
        }
    }

// MARK: - Updating Pokemon List

extension PokemonListViewController: PokemonManagerDelegate{
    func didUpdatePokemon(pokemon: PokemonModel) {
        DispatchQueue.main.async {
            self.pokemonDictList[pokemon.number] = pokemon
            if self.searching == false{
               self.filteredPokemonList = self.pokemonDictList
               self.tableView.reloadData()
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func displayPokemonInTableViewCell(pokemon: PokemonModel, tableViewCell: PokemonCell?){
        tableViewCell?.pokemonName.text = pokemon.getPokemonName()
        tableViewCell?.pokemonNumber.text = "#\(pokemon.number)"
        tableViewCell?.pokemonImage.image = pokemon.getSpriteImg(spriteURL: pokemon.defaultSprite)
        tableViewCell?.backgroundColor = pokemon.typeColor
        tableViewCell?.pokemonTypeImg1.image = pokemon.getCellPokemonTypeIcon(pokemonType: pokemon.mainPokemonType)
        tableViewCell?.pokemonTypeImg2.image = nil
        
        if let secondaryType = pokemon.secondaryPokemonType{
            tableViewCell?.pokemonTypeImg2.image = pokemon.getCellPokemonTypeIcon(pokemonType:secondaryType)
        }
    }
}

// MARK: - UI Seearch Bar methods

extension PokemonListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        
        if searchText == ""{
            filteredPokemonList = pokemonDictList
            searching = false
        }
        
        else{
            fetchSearchedPokemon(search: searchText)
        }
        
        self.tableView.reloadData()
    }
    
    
    func fetchSearchedPokemon(search searchText: String){
        var searchResults = [Int:PokemonModel]()
        var counter = 1
        
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
}


