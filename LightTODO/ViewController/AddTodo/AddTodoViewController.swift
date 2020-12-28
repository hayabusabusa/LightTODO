//
//  AddTodoViewController.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/28.
//

import UIKit

final class AddTodoViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var titleTextView: UITextView!
    @IBOutlet private weak var detailTextView: UITextView!
    
    // MARK: Properties
    
    private let model = AddTodoModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureModel()
    }
    
    @objc
    private func onTapCancelBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onTapAddBarButtonItem() {
        model.addTodo(title: titleTextView.text, detail: detailTextView.text)
    }
}

// MARK: - Configure

extension AddTodoViewController {
    
    private func configureNavigation() {
        navigationItem.title = "TODOを追加"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onTapCancelBarButtonItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .done, target: self, action: #selector(onTapAddBarButtonItem))
    }
    
    private func configureModel() {
        model.delegate = self
    }
}

// MARK: - MVC Model

extension AddTodoViewController: AddTodoModelDelegate {
    
    func onSuccess() {
        let alert = UIAlertController(title: "", message: "追加が完了しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func onError(with message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
