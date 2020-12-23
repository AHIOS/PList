import Foundation
import UIKit

class ProgressBar: UIView {
    var color: UIColor = .gray {
        didSet {
            gradientColor = color.darker(by: 10)!
            backgroundColor = color.lighter(by: 30)?.colorWithBrightnessFactor(factor: 0.7).withAlphaComponent(0.6)
            setNeedsDisplay()
        }
    }
    var gradientColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    private let progressLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    private let backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        createAnimation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
        createAnimation()
    }

    private func setupLayers() {
        layer.addSublayer(gradientLayer)

        gradientLayer.mask = progressLayer
        gradientLayer.locations = [0.35, 0.5, 0.65]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    }

    private func createAnimation() {
        let movingAnimation = CABasicAnimation(keyPath: "locations")
        movingAnimation.fromValue = [-0.3, -0.15, 0]
        movingAnimation.toValue = [1, 1.15, 1.3]

        movingAnimation.isRemovedOnCompletion = false
        movingAnimation.repeatCount = Float.infinity
        movingAnimation.duration = 2

        gradientLayer.add(movingAnimation, forKey: "flowAnimation")
    }

    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask

        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))

        progressLayer.frame = progressRect
        progressLayer.backgroundColor = UIColor.black.cgColor

        gradientLayer.frame = rect
        gradientLayer.colors = [color.cgColor, gradientColor.cgColor, color.cgColor]
        gradientLayer.endPoint = CGPoint(x: progress, y: 0.5)
    }
}


