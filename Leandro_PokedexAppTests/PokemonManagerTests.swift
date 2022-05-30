import XCTest
@testable import Leandro_PokedexApp

class PokemonManagerTests: XCTestCase {
    
    var sut: PokemonManager!
    var sut2: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = PokemonManager()
    }

    override func tearDown(){
        sut = nil
        super.tearDown()
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut2 = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut2 = nil
        try super.tearDownWithError()
    }
    
    func test_fetch_pokemon_url(){
        let expectedURL = "https://pokeapi.co/api/v2/pokemon/1"
        let actualURL = sut.fetchPokemonURL(number: 1)
        XCTAssertEqual(expectedURL, actualURL)
    }
    
    func test_sucessfull_api_request(){
        let promise = expectation(description: "Status code: 200")
        
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1") {
            let task = sut2.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    XCTFail("Error \(error?.localizedDescription)")
                    return
                } else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                    if statusCode == 200{
                        promise.fulfill()
                    }
                    else { XCTFail("Status code: \(statusCode)") }
                }
            }
            task.resume()
        }
        wait(for: [promise], timeout: 5)
    }
    
    func test_api_call_was_completed(){
        let promise = expectation(description: "Status code: 200")
        var statusCode: Int?
        var responseError: Error?
        
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") {
            let task = sut2.dataTask(with: url) { (data, response, error) in
                statusCode = (response as? HTTPURLResponse)?.statusCode
                responseError = (response as? Error)
                promise.fulfill()
            }
            task.resume()
            wait(for: [promise], timeout: 5)
        }
        
        XCTAssertNil(responseError)
        XCTAssertEqual(200, statusCode)
    }

}
