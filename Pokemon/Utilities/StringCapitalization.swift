//
//  StringCapitalization.swift
//  Pokemon
//
//  Created by Rastislav Smolen on 20/04/2021.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
