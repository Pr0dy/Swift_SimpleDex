import Foundation
import UIKit

struct PokemonModel{
    var name: String
    let number: Int
    var isFavortite: Bool
    let defaultSprite: String
    let mainPokemonType: String
    let secondaryPokemonType: String?
    let height: Int
    let stats: [Stats]
    var convertHeight: String{
        get{
            return String(format: "%.1f", Float(height) / 10)
        }
    }
    let weight: Int
    var convertWeight: String{
        get{
            return String(format: "%.1f", Float(weight) / 10)
        }
    }
    let shinySprite: String
    
    init(pokemonName: String, pokemonNumber: Int, defaultSprite: String, mainPokemonType: String, secondaryPokemonType: String? = nil, height: Int, weight: Int, shinySprite: String, pokeStats: [Stats]){
        self.name = pokemonName
        self.number = pokemonNumber
        self.defaultSprite = defaultSprite
        self.mainPokemonType = mainPokemonType
        self.secondaryPokemonType = secondaryPokemonType
        self.height = height
        self.weight = weight
        self.shinySprite = shinySprite
        self.stats = pokeStats
        self.isFavortite = false
    }
    
    func getSpriteImg(spriteURL: String) -> UIImage{
        let imageUrl = URL(string: spriteURL)!
        let imageData = try! Data(contentsOf: imageUrl)
        return UIImage(data: imageData)!
    }
    
    func getPokemonName() -> String{
        let first = String(name.prefix(1).capitalized)
        let other = String(name.dropFirst())
        return first + other
    }

    func getCellPokemonTypeIcon(pokemonType type: String?) -> UIImage  {
        var image: UIImage
        switch(type){
        case "fire": image = UIImage(named: "FireTypeIcon")!; break;
        case "water": image = UIImage(named: "WaterTypeIcon")!; break;
        case "grass": image = UIImage(named: "GrassTypeIcon")!; break;
        case "flying": image = UIImage(named: "FlyingTypeIcon")!; break;
        case "poison": image = UIImage(named: "PoisonTypeIcon")!; break;
        case "ground": image = UIImage(named: "GroundTypeIcon")!; break;
        case "rock": image = UIImage(named: "RockTypeIcon")!; break;
        case "bug": image = UIImage(named: "BugTypeIcon")!; break;
        case "ghost": image = UIImage(named: "GhostTypeIcon")!; break;
        case "steel": image = UIImage(named: "SteelTypeIcon")!; break;
        case "electric": image = UIImage(named: "ElectricTypeIcon")!; break;
        case "psychic": image = UIImage(named: "PsychicTypeIcon")!; break;
        case "ice": image = UIImage(named: "IceTypeIcon")!; break;
        case "dragon": image = UIImage(named: "DragonTypeIcon")!; break;
        case "dark": image = UIImage(named: "DarkTypeIcon")!; break;
        case "fairy": image = UIImage(named: "FairyTypeIcon")!; break;
        case "fighting": image = UIImage(named: "FightingTypeIcon")!; break;
        default: image = UIImage(named: "NormalTypeIcon")!; break;
        }
        return image
    }
    
    
    var typeColor: UIColor{
        get{
            var color: UIColor
            switch(mainPokemonType){
            case "normal": color = UIColor(red: CGFloat(168) / 255.0, green: CGFloat(168) / 255.0, blue: CGFloat(125) / 255.0, alpha: 1.0);break;
            case "fire": color = UIColor(red: CGFloat(242) / 255.0, green: CGFloat(171) / 255.0, blue: CGFloat(101) / 255.0, alpha: 1.0); break;
            case "water": color = UIColor(red: CGFloat(112) / 255.0, green: CGFloat(143) / 255.0, blue: CGFloat(233) / 255.0, alpha: 1.0); break;
            case "grass": color = UIColor(red: CGFloat(139) / 255.0, green: CGFloat(198) / 255.0, blue: CGFloat(96) / 255.0, alpha: 1.0); break;
            case "flying": color = UIColor(red: CGFloat(164) / 255.0, green: CGFloat(145) / 255.0, blue: CGFloat(234) / 255.0, alpha: 1.0); break;
            case "poison": color = UIColor(red: CGFloat(148) / 255.0, green: CGFloat(70) / 255.0, blue: CGFloat(155) / 255.0, alpha: 1.0); break;
            case "ground": color = UIColor(red: CGFloat(291) / 255.0, green: CGFloat(193) / 255.0, blue: CGFloat(117) / 255.0, alpha: 1.0); break;
            case "rock": color = UIColor(red: CGFloat(180) / 255.0, green: CGFloat(161) / 255.0, blue: CGFloat(75) / 255.0, alpha: 1.0); break;
            case "bug": color = UIColor(red: CGFloat(171) / 255.0, green: CGFloat(185) / 255.0, blue: CGFloat(66) / 255.0, alpha: 1.0); break;
            case "ghost": color = UIColor(red: CGFloat(108) / 255.0, green: CGFloat(89) / 255.0, blue: CGFloat(148) / 255.0, alpha: 1.0); break;
            case "steel": color = UIColor(red: CGFloat(180) / 255.0, green: CGFloat(180) / 255.0, blue: CGFloat(202) / 255.0, alpha: 1.0); break;
            case "electric": color = UIColor(red: CGFloat(242) / 255.0, green: CGFloat(210) / 255.0, blue: CGFloat(84) / 255.0, alpha: 1.0); break;
            case "psychic": color = UIColor(red: CGFloat(230) / 255.0, green: CGFloat(99) / 255.0, blue: CGFloat(136) / 255.0, alpha: 1.0); break;
            case "ice": color = UIColor(red: CGFloat(166) / 255.0, green: CGFloat(214) / 255.0, blue: CGFloat(215) / 255.0, alpha: 1.0); break;
            case "dragon": color = UIColor(red: CGFloat(105) / 255.0, green: CGFloat(59) / 255.0, blue: CGFloat(239) / 255.0, alpha: 1.0); break;
            case "dark": color = UIColor(red: CGFloat(108) / 255.0, green: CGFloat(89) / 255.0, blue: CGFloat(74) / 255.0, alpha: 1.0); break;
            case "fairy": color = UIColor(red: CGFloat(226) / 255.0, green: CGFloat(157) / 255.0, blue: CGFloat(172) / 255.0, alpha: 1.0); break;
            case "fighting": color = UIColor(red: CGFloat(177) / 255.0, green: CGFloat(61) / 255.0, blue: CGFloat(49) / 255.0, alpha: 1.0); break;
            default: color = UIColor.white; break;
            }
            return color
        }
    }
}
