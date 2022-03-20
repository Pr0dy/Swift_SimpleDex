import Foundation

protocol PokemonManagerDelegate{
    func didFailWithError(error: Error)
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel)
}

struct PokemonManager{
    
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemon(number: Int){
        let pokemonBaseURL = "\(AppStrList().pokemonBaseURL)\(number)"
        performRequest(with: pokemonBaseURL)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let pokemon = self.parseJSON(safeData) {
                        print(pokemon.name)
                        //self.delegate?.didUpdatePokemon(self, weather: pokemon)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ pokemonData: Data) -> PokemonModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemonName = decodedData.name
            //let sprites = decodedData.sprites
            let pokemon = PokemonModel(name: pokemonName /*,default_sprite: sprites.front_default*/)
            return pokemon
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

