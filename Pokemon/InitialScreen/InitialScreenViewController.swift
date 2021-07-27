//
//  InitialScreenViewController.swift
//  Pokemon
//
//  Created by Rastislav Smolen on 12/04/2021.
//

import Foundation
import UIKit

class TableViewCell : UITableViewCell {
    @IBOutlet var cell: UIView!
}

class InitialViewController : UIViewController,UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var pokemons = [PokemonRoot]()
    var pokemonDetail = [Pokemon]()
    private var model : InitialScreenViewModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        model = InitialScreenViewModel()
        fetchData()
    }
    
    private func fetchData(){
        model?.fetchData { [weak self] (pokemon,err) in
            guard let pokemon = pokemon else { return }
            self?.useData(data: pokemon)
        }
    }

    private func useData(data: [PokemonRoot]) {
        for result in data {
            guard let result = result.results else { return }
            pokemonDetail.append(contentsOf: result)
        }
    }
}

extension InitialViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonDetail.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = pokemonDetail[indexPath.row].name?.capitalized
      
        return cell
    }

}
