//
//  ViewController.swift
//  GradientLabelExample
//
//  Created by Bella Ádám on 4/27/20.
//  Copyright © 2020 Bella Ádám. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var lblExpandable: ExpandableGradientLabel!

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()

        performViews()
        performStyle()
    }

}

extension ViewController: ExpandableGradientLabelDelegate {

    func willChangeExpandableState(_ label: ExpandableGradientLabel) {
        NSLog("willChangeExpandableState")
    }

    func didChangeExpandableState(in label: ExpandableGradientLabel, state: ExpandableState, operation: ExpandableOperation) {
        NSLog("didChangeExpandableState")
    }

}

private extension ViewController {

    final func performViews() {
        lblExpandable.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sollicitudin sit aliquam, sollicitudin egestas dui amet, sit tempus amet. Purus diam neque est amet urna viverra. Tortor diam metus, varius dolor feugiat. Commodo faucibus luctus tempor elit cursus turpis."
    }

    final func performStyle() {
        lblExpandable.numberOfExpandedLines = 0
        lblExpandable.numberOfCollapsedLines = 3
        lblExpandable.textColor = .white
        lblExpandable.gradientStartColor = .white
        lblExpandable.gradientEndColor = .clear
        lblExpandable.delegate = self
    }

}
