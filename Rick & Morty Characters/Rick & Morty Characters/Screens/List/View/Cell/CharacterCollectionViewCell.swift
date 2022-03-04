//
//  CharacterCollectionViewCell.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterLabel: UILabel!
    
    static let identifier = String(describing: CharacterCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(imageUrl: String, name: String) {
        characterLabel.text = name
        characterImage.setImage(URL(string: imageUrl))
        characterImage.layer.cornerRadius = 15
        self.layer.cornerRadius = 30
    }

}
