import Foundation

struct PokemonData: Codable{
    let name: String
    let sprites: Sprites
}

struct Sprites: Codable{
    let front_default: String
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}
