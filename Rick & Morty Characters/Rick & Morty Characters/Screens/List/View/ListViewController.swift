//
//  ViewController.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

import Alamofire
import JGProgressHUD

final class ListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private lazy var viewModel = ListViewModel(output: self)
    
    private lazy var loadingView = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ListViewModel(output: self)
        displayLoading()
        viewModel.getCharacters()
        
        
        collectionView.register(UINib(nibName: CharacterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCharactersCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell,
              let character = viewModel.getCharacterFor(index: indexPath.row) else { return UICollectionViewCell() }
        cell.setup(imageUrl: character.image, name: character.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.layer.bounds.width
        
        let width = (availableWidth - 12 ) / 2
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Passar isso pra outro lugar
        guard let selectedCharacter = viewModel.getCharacterFor(index: indexPath.row) else { return }
        let vc = DetailsViewController(character: selectedCharacter)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                     willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if viewModel.getCharactersCount() - 1 == indexPath.row {
            // Aqui poderia entrar uma loading, mas como a API retorna extremamente rápdio, o app ficou mais fluido sem o loading, apresentando uma performance boa
            viewModel.getCharacters()
        }
    }
    
    func displayLoading() {
        loadingView.show(in: self.view, animated: true)
    }
    
    func hideLoading() {
        loadingView.dismiss()
    }
}

// MARK: - ViewModel
extension ListViewController: ListViewModelOutput {
    func charactersHasLoad() {
        DispatchQueue.main.async {
            if self.loadingView.isVisible {
                self.hideLoading()
            }
            self.collectionView.reloadData()
        }
    }
}
