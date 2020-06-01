//
//  CommunityNewsItemView.swift
//  WWDC
//
//  Created by Guilherme Rambo on 31/05/20.
//  Copyright © 2020 Guilherme Rambo. All rights reserved.
//

import Cocoa
import ConfCore
import PlayerUI

final class CommunityNewsItemView: NSView {

    var newsItem: CommunityNewsItemViewModel? {
        didSet {
            updateUI()
        }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private lazy var titleLabel: WWDCTextField = {
        let v = WWDCTextField(wrappingLabelWithString: "")

        v.font = NSFont.wwdcRoundedSystemFont(ofSize: 16, weight: .semibold)
        v.textColor = .primaryText
        v.setContentHuggingPriority(.defaultLow, for: .horizontal)
        v.setContentCompressionResistancePriority(.required, for: .horizontal)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.allowsDefaultTighteningForTruncation = true
        v.maximumNumberOfLines = 2
        v.isSelectable = false

        return v
    }()

    private lazy var shareButton: VectorButton = {
        let v = VectorButton(assetNamed: "share-vector")

        v.target = self
        v.action = #selector(share)
        v.toolTip = "Share"
        v.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        v.widthAnchor.constraint(equalToConstant: 13).isActive = true
        v.heightAnchor.constraint(equalToConstant: 16).isActive = true
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .roundedCellBackground
        
        return v
    }()

    private lazy var summaryLabel: NSTextField = {
        let v = NSTextField(wrappingLabelWithString: "")

        v.font = NSFont.systemFont(ofSize: 14)
        v.textColor = .secondaryText
        v.translatesAutoresizingMaskIntoConstraints = false
        v.allowsDefaultTighteningForTruncation = true
        v.maximumNumberOfLines = 4
        v.isSelectable = false

        return v
    }()

    private lazy var tagView: CommunityTagView = {
        CommunityTagView()
    }()

    private lazy var dateLabel: NSTextField = {
        let v = NSTextField(labelWithString: "")

        v.font = NSFont.systemFont(ofSize: 12)
        v.textColor = .tertiaryText
        v.alignment = .right
        v.translatesAutoresizingMaskIntoConstraints = false
        v.maximumNumberOfLines = 1
        v.isSelectable = false

        return v
    }()

    override var isOpaque: Bool { true }

    private func setup() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.roundedCellBackground.cgColor

        addSubview(titleLabel)
        addSubview(shareButton)
        addSubview(summaryLabel)
        addSubview(tagView)
        addSubview(dateLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            shareButton.topAnchor.constraint(equalTo: topAnchor),
            shareButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: shareButton.leadingAnchor, constant: -6),
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            summaryLabel.bottomAnchor.constraint(lessThanOrEqualTo: tagView.topAnchor, constant: 12),
            tagView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tagView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: tagView.centerYAnchor)
        ])
    }

    private lazy var dateFormatter: DateFormatter = {
        let f = DateFormatter()

        f.dateStyle = .short
        f.timeStyle = .none
        f.doesRelativeDateFormatting = true

        return f
    }()

    private func updateUI() {
        guard let item = newsItem else { return }

        titleLabel.stringValue = item.title
        titleLabel.toolTip = item.title
        dateLabel.stringValue = dateFormatter.string(from: item.date)
        summaryLabel.attributedStringValue = item.attributedSummary ?? NSAttributedString()
    }

    override func prepareForReuse() {
        summaryLabel.attributedStringValue = NSAttributedString()
        titleLabel.stringValue = ""
        dateLabel.stringValue = ""
        titleLabel.toolTip = nil
        tagView.isHidden = true
    }

    @objc private func share() {
        fatalError("Not implemented")
    }
    
}
