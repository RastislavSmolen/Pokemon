//
//  InitialScreenViewModel.swift
//  Pokemon
//
//  Created by Rastislav Smolen on 12/04/2021.
//

import Foundation
class InitialScreenViewModel {

    var networking : NetworkingProtoccol
    var pokemon = [PokemonRoot]()

    init(networking : NetworkingProtoccol = Networking()) {
        self.networking = networking
    }

    func fetchData(completion: @escaping ((_ data: [PokemonRoot]?,_ err: String?) -> Void)) {
        guard let url = URL(string: APIEndpoit.pokemonList.api()) else { return }
        networking.fetchData(url: url, type: PokemonRoot.self){ (result) in
            switch result {
            case.success(let response): completion( [response], nil )
            case.failure(let error): completion( nil, error.localizedDescription )
                DispatchQueue.main.async {
                    print("response is not working")
                }
            }
        }
    }
}
