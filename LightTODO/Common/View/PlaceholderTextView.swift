//
//  PlaceholderTextView.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/28.
//

import UIKit

class PlaceholderTextView: UITextView {
    
    // MARK: IBInspectable

    @IBInspectable var placeholder: String = ""
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray.withAlphaComponent(0.25)

    // MARK: Properties

    private var placeholderLabel = UILabel()
    private var notificationToken: NSObjectProtocol?
    
    deinit {
        if let notificationToken = notificationToken {
            NotificationCenter.default.removeObserver(notificationToken)
        }
    }

    // MARK: Override

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configure()
    }

    // MARK: Configure

    private func configure() {
        isExclusiveTouch = true
        configurePlaceholderLabel()
    }

    private func configurePlaceholderLabel() {
        placeholderLabel.text = placeholder
        placeholderLabel.font = font
        placeholderLabel.numberOfLines = 1
        placeholderLabel.textColor = UIColor.lightGray.withAlphaComponent(3)
        placeholderLabel.textAlignment = .left
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4.0),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0)
        ])

        notificationToken = NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: nil) { [weak self] _ in
            guard let text = self?.text else { return }
            self?.placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
