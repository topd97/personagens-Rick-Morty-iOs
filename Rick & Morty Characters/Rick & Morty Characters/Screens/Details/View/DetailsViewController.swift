//
//  DetailsViewController.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 03/03/22.
//

import UIKit
import JGProgressHUD

final class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var episodesStackView: UIStackView!
    
    let viewModel: DetailsViewModel
    
    private lazy var loadingView = JGProgressHUD()
    
    init(character: RickMortyCharacter) {
        self.viewModel = DetailsViewModel(character: character)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = DetailsViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLoading()
        viewModel.setup(output: self)
        viewModel.loadData()
    }
    
    private func setupView() {
        guard let character = self.viewModel.getCharacter() else { return }
        
        self.backButton.tintColor = .black

        self.nameLabel.text = character.name
        if character.status != "" {
            self.statusLabel.isHidden = false
            let statusAttributedText = NSMutableAttributedString(string: "Status: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            statusAttributedText.append(NSAttributedString(string: character.status, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
            
            self.statusLabel.attributedText = statusAttributedText
        } else {
            self.statusLabel.isHidden = true
        }
        
        if character.species != "" {
            self.speciesLabel.isHidden = false
            let specieAttributedText = NSMutableAttributedString(string: "Espécie: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            specieAttributedText.append(NSAttributedString(string: character.species, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
            
            self.speciesLabel.attributedText = specieAttributedText
        } else {
            self.speciesLabel.isHidden = true
        }
        
        if character.type != "" {
            self.typeLabel.isHidden = false
            let typeAttributedText = NSMutableAttributedString(string: "Tipo: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            typeAttributedText.append(NSAttributedString(string: character.type, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
            
            self.typeLabel.attributedText = typeAttributedText
        } else {
            self.typeLabel.isHidden = true
        }
        
        self.imageView.setImage(URL(string: character.image))
        self.imageView.layer.cornerRadius = 15
        self.imageView.layer.borderColor = UIColor.black.cgColor
        self.imageView.layer.borderWidth = 2
        
        self.episodesView.layer.cornerRadius = 15
        self.episodesView.layer.borderColor = UIColor.black.cgColor
        self.episodesView.layer.borderWidth = 2
        
        let episodes = self.viewModel.getCharacterEpisodes()
        for episode in episodes {
            let label = UILabel()
            label.text = "\(episode.episode) - \(episode.name)"
            self.episodesStackView.addArrangedSubview(label)
        }
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayLoading() {
        loadingView.show(in: self.view, animated: true)
    }
    
    func hideLoading() {
        loadingView.dismiss()
    }
}
    
// MARK: - ViewModel
extension DetailsViewController: DetailsViewModelProtocol {
    func didLoadData() {
        DispatchQueue.main.async {
            self.hideLoading()
            self.setupView()
        }
    }
}
