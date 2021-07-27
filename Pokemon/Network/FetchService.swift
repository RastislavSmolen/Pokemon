//
//  FetchService.swift
//  Pokemon
//
//  Created by Rastislav Smolen on 12/04/2021.
//

import Foundation

enum NetworkError: Error {
    case parsingFailed(message: String)
    case errorWith(message: String)
    case networkNotAvailalbe
    case malformedURL(message: String)
    case malformedLocalizedJsonFile(message: String)
}
enum APIEndpoit:String{
    case pokemonList = "https://pokeapi.co/api/v2/pokemon"
    case pokemonJsonFile = "pokemonApiMock"
    func api() ->String { return self.rawValue }
}
protocol NetworkingProtoccol {

    func fetchData<T: Codable>(url:URL,type: T.Type,completionHandler: @escaping (Result<T,NetworkError>) -> Void)
}
class Networking: NetworkingProtoccol {
    
    func fetchData<T: Codable>(url: URL,type: T.Type, completionHandler: @escaping (Result<T,NetworkError>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url,completionHandler : { (data, response, error) in
            
            if let error = error {
                print("Error with fetching accounts: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response , unexpected status code:\(String(describing: response))")
                return
            }
            
            guard let data = data else {return}
            
            do {
                let dataSummary = try JSONDecoder().decode(type, from: data)
                completionHandler(.success(dataSummary))
            } catch {
                completionHandler(.failure(NetworkError.parsingFailed(message: "failed")))
            }
        })
        task.resume()
    }
    
}
