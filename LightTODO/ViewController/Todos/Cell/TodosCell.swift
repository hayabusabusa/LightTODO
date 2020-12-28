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
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    func configureCell(title: String, detail: String?) {
        titleLabel.text = title
        detailLabel.text = detail
        detailLabel.isHidden = detail == nil
    }
}
