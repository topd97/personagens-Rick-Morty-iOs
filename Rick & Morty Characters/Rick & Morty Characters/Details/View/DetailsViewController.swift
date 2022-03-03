//
//  DetailsViewController.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 03/03/22.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // passar para o viewModel
    var character: RickMortyCharacter?
    
    init(character: RickMortyCharacter) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        guard let character = character else { return }

        nameLabel.text = character.name
        statusLabel.text = character.status
        speciesLabel.text = character.species
        typeLabel.text = character.type

        imageView.setImage(URL(string: character.image))
        imageView.layer.cornerRadius = 15
    }

}
