//
//  TodoViewController.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/28.
//

import UIKit

final class TodoViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var titleTextView: UITextView!
    @IBOutlet private weak var detailTextView: UITextView!
    
    // MARK: Properties
    
    private let todo: Todo
    private let model = TodoModel()
    
    // MARK: Lifecycle
    
    init?(coder: NSCoder, todo: Todo) {
        self.todo = todo
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureModel()
        configureLayout()
    }
    
    @objc
    private func onTapRemoveBarButtonItem() {
        let alert = UIAlertController(title: "", message: "TODOを削除しますか？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.model.removeTodo(of: self.todo.id)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Configure

extension TodoViewController {
    
    private func configureNavigation() {
        navigationItem.title = "TODO詳細"
        let rightBarButtonItem = UIBarButtonItem(title: "削除", style: .plain, target: self, action: #selector(onTapRemoveBarButtonItem))
        rightBarButtonItem.tintColor = .systemRed
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func configureModel() {
        model.delegate = self
    }
    
    private func configureLayout() {
        titleTextView.text = todo.title
        detailTextView.text = todo.detail ?? ""
    }
}

// MARK: - MVC Model

extension TodoViewController: TodoModelDelegate {
    
    func onSuccess() {
        let alert = UIAlertController(title: "", message: "削除が完了しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] _ in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
