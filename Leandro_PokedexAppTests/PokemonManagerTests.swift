import XCTest
@testable import Leandro_PokedexApp

class PokemonManagerTests: XCTestCase {
    
    var sut: PokemonManager!
    
    override func setUp() {
        super.setUp()
        sut = PokemonManager()
    }

    override func tearDown(){
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_pokemon_url(){
        
        let expectedURL = "https://pokeapi.co/api/v2/pokemon/1"
        
        let actualURL = sut.fetchPokemonURL(number: 1)
        
        XCTAssertEqual(expectedURL, actualURL)
    }

}
