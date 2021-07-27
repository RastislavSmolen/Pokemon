//
//  PokemonTests.swift
//  PokemonTests
//
//  Created by Rastislav Smolen on 12/04/2021.
//

import XCTest
@testable import Pokemon

class PokemonTests: XCTestCase {
    
    var networking = MockNetworking()
    var viewModel : InitialScreenViewModel?
    
    override func setUp() {
        viewModel = InitialScreenViewModel(networking: networking)
        super.setUp()
    }
    func testFetchDataSuccessScenario(){
        
        viewModel?.fetchData{(results,err) in
            XCTAssertEqual(results?.first?.results?.count,20)
            XCTAssertEqual(results?.count,1)
            XCTAssertEqual(results?.first?.results?.first?.name,"bulbasaur")
            XCTAssertNotNil(results?.first?.results?.first?.name)
        }
    }
    func testFetchDataFailScenario(){
        
        networking.responseFileName = "failure"
        viewModel?.fetchData{(results,err) in
            XCTAssertNil(results?.first?.results?.count)
            XCTAssertNil(results?.first?.results?.first?.name)
            XCTAssertNil(results?.first?.results?.first?.name)
        }
    }
    
}
class MockNetworking: NetworkingProtoccol {
    
    var responseFileName = APIEndpoit.pokemonJsonFile.api()
    func fetchData<T: Codable>(url: URL, type: T.Type, completionHandler: @escaping (Result<T,NetworkError>) -> Void) {
        
        guard let path = Bundle.main.path(forResource: responseFileName, ofType: "json") else {
            completionHandler(.failure(NetworkError.malformedLocalizedJsonFile(message: "json file not found/ is not correctly formed")))
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        let jsonData = try? Data(contentsOf: url)
        guard let data = jsonData else {return}
        do {
            let dataSummary = try JSONDecoder().decode(type, from: data)
            completionHandler(.success(dataSummary))
        } catch {
            completionHandler(.failure(NetworkError.parsingFailed(message: "parsing failed")))
        }
    }
}

