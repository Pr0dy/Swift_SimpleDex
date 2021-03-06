import Foundation

protocol PokemonManagerDelegate{
    func didFailWithError(error: Error)
    func didUpdatePokemon(pokemon: PokemonModel)
}
 
struct PokemonManager{
    
    var delegate: PokemonManagerDelegate?
    
     func fetchPokemonURL(number: Int) -> String{
        let pokemonBaseURL = "\(AppConstants().pokemonBaseURL)\(number)"
        return pokemonBaseURL
    }
    
     func performRequest(number: Int){
        if let url = URL(string: fetchPokemonURL(number: number)) {
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
            let pokemon: PokemonModel
            
            if decodedData.types.count > 1{
                pokemon = PokemonModel(pokemonName: decodedData.name, pokemonNumber: decodedData.id, defaultSprite: decodedData.sprites.front_default, mainPokemonType: decodedData.types[0].type.name, secondaryPokemonType: decodedData.types[1].type.name, height: decodedData.height, weight: decodedData.weight, shinySprite: decodedData.sprites.front_shiny!, pokeStats: decodedData.stats)
            } else {
                pokemon = PokemonModel(pokemonName: decodedData.name, pokemonNumber: decodedData.id, defaultSprite: decodedData.sprites.front_default, mainPokemonType: decodedData.types[0].type.name, height: decodedData.height, weight: decodedData.weight, shinySprite: decodedData.sprites.front_shiny!,  pokeStats: decodedData.stats)
            }
            
            return pokemon
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

