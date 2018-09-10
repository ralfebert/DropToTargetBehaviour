import UIKit

class DropToTargetBehaviour {

    var dragView: UIView!
    var dropAreaView: UIView!

    let animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear)

    var dragRange : ClosedRange<CGFloat> = 0...0

    init(dragView: UIView, dropAreaView: UIView) {
        self.dragView = dragView
        self.dropAreaView = dropAreaView
        self.dragRange = 0...(self.dropAreaView.center.y - self.dragView.center.y)

        self.dragView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:))))

        animator.pausesOnCompletion = true
        animator.addAnimations {
            UIView.animateKeyframes(withDuration: 0, delay: 0, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                    self.dragView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    self.dragView.transform = .identity
                })
            })
            self.dragView.center = self.dropAreaView.center
        }

    }

    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.dragView)

        let progress = dragRange.clampedFraction(value: translation.y)
        let complete = progress > 0.8

        animator.isReversed = false
        animator.fractionComplete = progress
        self.dropAreaHighlighted = complete

        if recognizer.state == .ended {
            animator.isReversed = !complete
            animator.startAnimation()
            self.dropAreaHighlighted = false
        }

    }

    let dropAreaHighlightAnimator = UIViewPropertyAnimator(duration: 0, timingParameters: UISpringTimingParameters(damping: 0.3, response: 0.3))

    var dropAreaHighlighted : Bool = false {
        didSet {
            let scale : CGFloat = self.dropAreaHighlighted ? 1.2 : 1.0
            self.dropAreaHighlightAnimator.addAnimations {
                self.dropAreaView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            self.dropAreaHighlightAnimator.startAnimation()
        }
    }


    deinit {
        animator.stopAnimation(true)
    }

}

class ExampleViewController: UIViewController {

    @IBOutlet var orangeView: UIView!
    @IBOutlet var dropAreaView: UIImageView!
    @IBOutlet var slider: UISlider!

    var behaviour : DropToTargetBehaviour!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.orangeView.layer.cornerRadius = 10

        self.behaviour = DropToTargetBehaviour(dragView: self.orangeView, dropAreaView: self.dropAreaView)
    }

    @IBAction func handleSliderChange() {
        self.behaviour.animator.isReversed = false
        self.behaviour.animator.fractionComplete = CGFloat(slider.value)
    }

    @IBAction func handleReset(_: Any) {
        self.view.window?.rootViewController = ExampleViewController()
    }

}
