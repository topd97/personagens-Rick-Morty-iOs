//
//  ViewController.swift
//  Rick & Morty Characters
//
//  Created by thiago.damasceno on 02/03/22.
//

import Alamofire
import JGProgressHUD
import CoreGraphics

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
        let numberOfCells: CGFloat = UIDevice.isPad() ? 4 : 2
        let spacing: CGFloat = 12 * (numberOfCells - 1)
        
        let width = (availableWidth - spacing) / numberOfCells
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didTapItem(row: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                     willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if viewModel.getCharactersCount() - 1 == indexPath.row {
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
    
    func characterNotLoad() {
        DispatchQueue.main.async {
            if self.loadingView.isVisible {
                self.hideLoading()
            }
            
            let alert = UIAlertController(title: "Fail to get Characters", message: "It was not possible to get characters, try again later", preferredStyle: .alert)
            
            if self.viewModel.getCharactersCount() != 0 {
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] _ in
                    alert?.dismiss(animated: true, completion: nil)
                }))
            }
            alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [weak alert] _ in
                self.viewModel.getCharacters()
                alert?.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func present(vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
}
