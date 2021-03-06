//
//  TodosCell.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/28.
//

import UIKit

class TodosCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "TodosCell"
    static let itemSize: CGSize = CGSize(width: 320, height: 98)
    static var nib: UINib {
        return UINib(nibName: "TodosCell", bundle: nil)
    }
    
    var onTapButton: (() -> Void)?
    
    // MARK: Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .systemFill
        selectedBackgroundView.layer.cornerRadius = 8
        self.selectedBackgroundView = selectedBackgroundView
        
        layer.cornerRadius = 8
        backgroundColor = .systemBackground

        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        
        let action = UIAction(handler: { [weak self] _ in
            guard let onTapButton = self?.onTapButton else {
                return
            }
            onTapButton()
        })
        button.addAction(action, for: .touchUpInside)
    }
    
    func configureCell(title: String, detail: String?, isCompleted: Bool) {
        titleLabel.text = title
        detailLabel.text = detail
        detailLabel.isHidden = detail == nil
        button.backgroundColor = isCompleted ? .systemBlue : .clear
        button.setImage(isCompleted ? UIImage(systemName: "checkmark") : nil, for: .normal)
    }
}
