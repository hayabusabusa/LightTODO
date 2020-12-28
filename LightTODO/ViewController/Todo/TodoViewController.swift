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
        configureLayout()
    }
    
    @objc
    private func onTapRemoveBarButtonItem() {
        
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
    
    private func configureLayout() {
        titleTextView.text = todo.title
        detailTextView.text = todo.detail ?? ""
    }
}
