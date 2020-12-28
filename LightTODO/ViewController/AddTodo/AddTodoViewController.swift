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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    @objc
    private func onTapCancelBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onTapAddBarButtonItem() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Configure

extension AddTodoViewController {
    
    private func configureNavigation() {
        navigationItem.title = "TODOを追加"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onTapCancelBarButtonItem))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .done, target: self, action: #selector(onTapAddBarButtonItem))
    }
}
