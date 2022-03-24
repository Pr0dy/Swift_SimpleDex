import Foundation

struct PokemonData: Codable{
    let name: String
    let sprites: Sprites
    let types: [Types]
}

struct Sprites: Codable{
    let front_default: String
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct Types: Codable{
    let slot: Int
    let type: TypeData
}

struct TypeData: Codable{
    let name: String
    let url: String
}
