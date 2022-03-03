//
//  UIImageView.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 03/03/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ url: URL?) {
        if let image = url {
            self.kf.setImage(
                with: image,
                placeholder: nil,
                options: [.transition(.fade(0.35))]
            )
        } else {
            self.image = nil
        }
    }
}
