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
    
    private let model = TodosModel()
    private var dataSource: [Todo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureCollectionView()
        configureModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model.getTodos()
    }
    
    @objc
    private func onTapBarButtonItem() {
        let vc = UINavigationController(rootViewController: UIStoryboard(name: "AddTodoViewController", bundle: nil).instantiateInitialViewController()!)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - Configure

extension TodosViewController {
    
    private func configureNavigation() {
        navigationItem.title = "TODO一覧"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onTapBarButtonItem))
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodosCell.nib, forCellWithReuseIdentifier: TodosCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(configureCollectionViewLayout(), animated: false)
    }
    
    private func configureModel() {
        model.delegate = self
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

// MARK: - MVC Model

extension TodosViewController: TodosModelDelegate {
    
    func onSuccess(todos: [Todo]) {
        dataSource = todos
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
        cell.onTapButton = { [weak self] in
            // NOTE: TODO の完了とリストのリフレッシュを実行
            self?.model.completeTodo(of: todo.id)
            self?.model.getTodos()
        }
        return cell
    }
}

// MARK: - CollectionView delegate

extension TodosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let todo = dataSource[indexPath.row]
        let vc = UIStoryboard(name: "TodoViewController", bundle: nil).instantiateInitialViewController { coder -> TodoViewController? in
            return TodoViewController(coder: coder, todo: todo)
        }
        navigationController?.pushViewController(vc!, animated: true)
    }
}
