import Foundation
import UIKit

struct PokemonModel{
    var name: String
    let number: Int
    let default_sprite: String
    var default_sprite_image: UIImage{
        get{
            let imageUrl = URL(string: default_sprite)!
            let imageData = try! Data(contentsOf: imageUrl)
            return UIImage(data: imageData)!
        }
    }
    
    func getPokemonName() -> String{
        let first = String(name.prefix(1).capitalized)
        let other = String(name.dropFirst())
        return first + other
    }
}
