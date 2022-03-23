import Foundation

protocol PokemonManagerDelegate{
    func didFailWithError(error: Error)
    func didUpdatePokemon(pokemon: PokemonModel)
}

struct PokemonManager{
    
    var delegate: PokemonManagerDelegate?
    var pokemonNum: Int?
    
    mutating func fetchPokemon(number: Int){
        let pokemonBaseURL = "\(AppStrList().pokemonBaseURL)\(number)"
        pokemonNum = number
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
                    if let pokemonData = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePokemon(pokemon: pokemonData)
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
            let pokemon = PokemonModel(name: decodedData.name, number: pokemonNum ?? 0, default_sprite: decodedData.sprites.front_default, main_type: decodedData.types[0].type!.name!)
            return pokemon
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

