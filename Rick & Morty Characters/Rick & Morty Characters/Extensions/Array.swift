//
//  Array.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

extension Array {
    
    func get(index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
