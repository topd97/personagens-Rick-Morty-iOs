//
//  UIDevice.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 04/03/22.
//

import UIKit

extension UIDevice {

    public static func isPad() -> Bool {
        return current.userInterfaceIdiom == .pad
    }
}
