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
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var episodesStackView: UIStackView!
    
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
        
        backButton.tintColor = .black

        nameLabel.text = character.name
        if character.status != "" {
            statusLabel.isHidden = false
            let statusAttributedText = NSMutableAttributedString(string: "Status: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            statusAttributedText.append(NSAttributedString(string: character.status, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
            
            statusLabel.attributedText = statusAttributedText
        } else {
            statusLabel.isHidden = true
        }
        
        if character.species != "" {
            speciesLabel.isHidden = false
            let specieAttributedText = NSMutableAttributedString(string: "Espécie: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            specieAttributedText.append(NSAttributedString(string: character.species, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
            
            speciesLabel.attributedText = specieAttributedText
        } else {
            speciesLabel.isHidden = true
        }
        
        if character.type != "" {
            typeLabel.isHidden = false
            let typeAttributedText = NSMutableAttributedString(string: "Tipo: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            typeAttributedText.append(NSAttributedString(string: character.type, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
            
            typeLabel.attributedText = typeAttributedText
        } else {
            typeLabel.isHidden = true
        }
        
        imageView.setImage(URL(string: character.image))
        imageView.layer.cornerRadius = 15
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
        
        episodesView.layer.cornerRadius = 15
        episodesView.layer.borderColor = UIColor.black.cgColor
        episodesView.layer.borderWidth = 2
        
        for episode in character.episode {
            Services.shared.getRickMortyEpisode(url: episode) { episode in
                let label = UILabel()
                label.text = "\(episode.episode) - \(episode.name)"
                self.episodesStackView.addArrangedSubview(label)
            }
        }
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
