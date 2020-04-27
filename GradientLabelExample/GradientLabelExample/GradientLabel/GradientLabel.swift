//
//  GradientLabel.swift
//  
//
//  Created by Bella Ádám on 3/27/20.
//  Copyright © 2020 Frontside Kft. All rights reserved.
//

import UIKit

class GradientLabel: UILabel {
    override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = .clear
        }
        get {
            return .clear
        }
    }

    var gradientStartPoint = CGPoint(x: 0, y: 0) {
        didSet {
            setNeedsDisplay()
        }
    }
    var gradientEndPoint = CGPoint(x: 0, y: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    var gradientStartColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    var gradientEndColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    var canFillGradient = true {
        didSet {
            setNeedsDisplay()
        }
    }

    override final func drawText(in rect: CGRect) {
        super.drawText(in: rect)
        
        guard canFillGradient else {
            return
        }

        var gradientColors = [CGColor]()

        if let gradientStartColor = gradientStartColor {
            gradientColors.append(gradientStartColor.cgColor)
        }

        if let gradientEndColor = gradientEndColor {
            gradientColors.append(gradientEndColor.cgColor)
        }

        guard gradientColors.count == 2 else {
            return
        }

        let context = UIGraphicsGetCurrentContext()

        // Save alpha mask.
        guard let alphaMask = context?.makeImage() else {
            return
        }

        context?.translateBy(x: 0, y: rect.height)
        context?.scaleBy(x: 1, y: -1)
        context?.saveGState()

        // Clip the current context to alpha mask.
        context?.clip(to: rect, mask: alphaMask)

        // Create gradient.
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors as CFArray, locations: .none) else {
            return
        }
        let startPoint = CGPoint(x: rect.origin.x + gradientEndPoint.x * rect.width,
                                 y: rect.origin.y + gradientEndPoint.y * rect.height)
        let endPoint = CGPoint(x: rect.origin.x + gradientStartPoint.x * rect.width,
                               y: rect.origin.y + gradientStartPoint.y * rect.height)

        context?.clear(rect)
        context?.saveGState()

        // Draw gradient.
        context?.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context?.restoreGState()
    }
}
