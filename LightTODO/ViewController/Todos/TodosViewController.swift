//
//  TodosViewController.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/25.
//

import UIKit

final class TodosViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var dataSource: [Todo] = [
        Todo(title: "TEST", detail: "TEST", isCompleted: false),
        Todo(title: "TEST", detail: "TEST", isCompleted: false)
    ] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
    }
}

// MARK: - Configure

extension TodosViewController {
    
    private func configureNavigation() {
        navigationItem.title = "TODO一覧"
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodosCell.nib, forCellWithReuseIdentifier: TodosCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(configureCollectionViewLayout(), animated: false)
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(TodosCell.itemSize.height))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(TodosCell.itemSize.height))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(8)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 8, leading: 24, bottom: 16, trailing: 24)
            return section
        }
        return layout
    }
}

// MARK: - CollectionView dataSource

extension TodosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let todo = dataSource[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodosCell.reuseIdentifier, for: indexPath) as! TodosCell
        cell.configureCell(title: todo.title, detail: todo.detail)
        return cell
    }
}

// MARK: - CollectionView delegate

extension TodosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
