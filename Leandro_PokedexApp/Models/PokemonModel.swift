import Foundation

struct PokemonModel{
    var name: String
    let number: Int
    //let default_sprite: String
    
    func getPokemonName() -> String{
        let first = String(name.prefix(1).capitalized)
        let other = String(name.dropFirst())
        return first + other
    }
}
