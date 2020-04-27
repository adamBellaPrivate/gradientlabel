//
//  ExpandableGradientLabel.swift
// 
//
//  Created by Bella Ádám on 3/27/20.
//  Copyright © 2020 Frontside Kft. All rights reserved.
//

import UIKit

protocol ExpandableGradientLabelDelegate: class {
    func willChangeExpandableState(_ label: ExpandableGradientLabel)
    func didChangeExpandableState(in label: ExpandableGradientLabel, state: ExpandableState, operation: ExpandableOperation)
}

enum ExpandableState {
    case collapsed, expanded
}

enum ExpandableOperation {
    case none, onlyExpandable, full
}

class ExpandableGradientLabel: GradientLabel {
    // MARK: - Public properties

    override final var numberOfLines: Int {
        set {
            super.numberOfLines = currentNumberOfLine
        }
        get {
            return super.numberOfLines
        }
    }

    var numberOfCollapsedLines: Int = 3 {
        didSet {
            updateExpandleSate()
        }
    }
    var numberOfExpandedLines: Int = 0 {
        didSet {
            updateExpandleSate()
        }
    }
    var expandleState: ExpandableState = .collapsed {
        didSet {
            updateExpandleSate()
        }
    }
    var operation: ExpandableOperation = .full
    weak var delegate: ExpandableGradientLabelDelegate?

    // MARK: - Private properties
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnView))
    private var currentNumberOfLine: Int = 0 {
        didSet {
            super.numberOfLines = currentNumberOfLine
        }
    }

    // MARK: - Lifecycle functions

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }
}

private extension ExpandableGradientLabel {
    final func commonInit() {
       updateExpandleSate()
       addGestureRecognizer(tapGesture)
       isUserInteractionEnabled = true
    }

    final func updateExpandleSate() {
        delegate?.willChangeExpandableState(self)
        switch expandleState {
        case .collapsed:
            canFillGradient = true
            currentNumberOfLine = numberOfCollapsedLines
        case .expanded:
            canFillGradient = false
            currentNumberOfLine = numberOfExpandedLines
        }

        setNeedsDisplay()
        delegate?.didChangeExpandableState(in: self, state: expandleState, operation: operation)
    }

    @objc
    final func didTapOnView() {
        switch operation {
        case .onlyExpandable where expandleState == .collapsed:
            expandleState = .expanded
        case .full where expandleState == .expanded:
            expandleState = .collapsed
        case .full where expandleState == .collapsed:
            expandleState = .expanded
        default:
            break
        }
    }
}
