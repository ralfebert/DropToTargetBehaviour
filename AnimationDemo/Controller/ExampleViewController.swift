import UIKit

class DropToTargetBehaviour {

    var dragView: UIView!
    var dropAreaView: UIView!

    init(dragView: UIView, dropAreaView: UIView) {
        self.dragView = dragView
        self.dropAreaView = dropAreaView

        self.dragView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
    }

    @IBAction func handleTap(_: UITapGestureRecognizer) {
        self.dragView.center = self.dropAreaView.center
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
    }

    @IBAction func handleReset(_: Any) {
        self.view.window?.rootViewController = ExampleViewController()
    }

}
