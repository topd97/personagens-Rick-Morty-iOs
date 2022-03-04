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
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var episodesView: UIView!
    @IBOutlet weak var episodesStackView: UIStackView!
    @IBOutlet weak var backButtonImageView: UIImageView!
    
    let viewModel: DetailsViewModel
    let textFontSize: CGFloat = UIDevice.isPad() ? 32 : 14
    
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
        
        backButtonImageView.tintColor = .white
        backButtonImageView.image = UIImage(systemName: "arrow.backward.circle")
        let tapContainer = UITapGestureRecognizer(target: self, action: #selector(onBackButton))
        backButtonImageView.isUserInteractionEnabled = true
        backButtonImageView.addGestureRecognizer(tapContainer)
        
        self.nameLabel.text = character.name
        setLabel(statusLabel, with: character.status, prefixText: "Status: ")
        setLabel(speciesLabel, with: character.species, prefixText: "Specie: ")
        setLabel(typeLabel, with: character.type, prefixText: "Type: ")
        setLabel(genderLabel, with: character.gender, prefixText: "Gender: ")
        setLabel(originLabel, with: character.origin.name, prefixText: "Origin: ")
        setLabel(locationLabel, with: character.location.name, prefixText: "Location: ")
        
        self.imageView.setImage(URL(string: character.image))
        self.imageView.layer.cornerRadius = 15
        self.imageView.layer.borderColor = UIColor.black.cgColor
        self.imageView.layer.borderWidth = 2
        
        self.episodesView.layer.cornerRadius = 15
        self.episodesView.layer.borderColor = UIColor.white.cgColor
        self.episodesView.layer.borderWidth = 2
        
        let episodes = self.viewModel.getCharacterEpisodes()
        if episodes.isEmpty {
            episodesView.isHidden = true
        } else {
            episodesView.isHidden = false
            
            for episode in episodes {
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: textFontSize)
                label.textColor = .white
                label.text = "\(episode.episode) - \(episode.name)"
                self.episodesStackView.addArrangedSubview(label)
            }
        }
    }
    
    private func setLabel(_ label: UILabel, with text: String, prefixText: String) {
        
        if text != "" {
            label.isHidden = false
            let statusAttributedText = NSMutableAttributedString(string: prefixText, attributes: [.font: UIFont.boldSystemFont(ofSize: textFontSize)])
            statusAttributedText.append(NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: textFontSize)]))
            
            label.attributedText = statusAttributedText
        } else {
            label.isHidden = true
        }
    }
    
    @objc func onBackButton() {
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
    
    func didFailToLoadEpisodes() {
        let alert = UIAlertController(title: "Fail to get episodes", message: "Some episodes could not be loaded, the episodes list could be incomplete", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] _ in
            alert?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
