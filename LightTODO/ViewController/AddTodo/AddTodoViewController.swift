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
    private var isEdited = false
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureTextView()
        configureModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .done, target: self, action: #selector(onTapAddBarButtonItem))
    }
    
    private func configureTextView() {
        titleTextView.delegate = self
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

// MARK: - UITextViewDelegate

extension AddTodoViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        isEdited = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension AddTodoViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return !isEdited
    }
    
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        guard isEdited else {
            return
        }
        
        let alert = UIAlertController(title: "", message: "編集状態を破棄しますか？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
