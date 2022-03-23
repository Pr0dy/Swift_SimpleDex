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
    
    let main_type: String
    var cell_color_type: UIColor{
        get{
            var color: UIColor
            
            switch(main_type){
            case "normal": color = UIColor(red: 168, green: 168, blue: 125, alpha: 1.00); break;
            case "fire": color = UIColor.red; break;
            case "water": color = UIColor.blue; break;
            case "grass": color = UIColor.green; break;
            //case "flying": color = UIColor.
            default: color = UIColor.white; break;
            }
            return color
        }
    }
    
    func getPokemonName() -> String{
        let first = String(name.prefix(1).capitalized)
        let other = String(name.dropFirst())
        return first + other
    }
}
