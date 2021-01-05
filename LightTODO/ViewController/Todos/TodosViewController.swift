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
    
    private var selectedType = TodoType.uncompleted
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
        model.getTodos(of: selectedType)
    }
    
    @objc
    private func onTapBarButtonItem() {
        let vc = UIStoryboard(name: "AddTodoViewController", bundle: nil).instantiateInitialViewController() as! AddTodoViewController
        let nvc = UINavigationController(rootViewController: vc)
        nvc.presentationController?.delegate = vc
        present(nvc, animated: true, completion: nil)
    }
}

// MARK: - Configure

extension TodosViewController {
    
    private func configureNavigation() {
        let segmentedControl = UISegmentedControl(items: TodoType.allCases.map { $0.title })
        let segmentedControlAction = UIAction { [weak self] _ in
            guard let selectedType = TodoType(rawValue: segmentedControl.selectedSegmentIndex) else {
                return
            }
            self?.selectedType = selectedType
            self?.model.toggleTodoCategory(to: selectedType)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addAction(segmentedControlAction, for: .valueChanged)
        navigationItem.titleView = segmentedControl
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
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = .init(top: 8, leading: 16, bottom: 16, trailing: 16)
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
        cell.configureCell(title: todo.title, detail: todo.detail, isCompleted: todo.isCompleted)
        cell.onTapButton = { [weak self] in
            // NOTE: TODO の完了とリストのリフレッシュを実行
            self?.model.toggleTodo(of: todo.id)
            self?.model.getTodos(of: self?.selectedType ?? .uncompleted)
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
