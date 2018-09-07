import UIKit

class ExampleViewController: UIViewController {

    @IBOutlet var orangeView: UIView!
    @IBOutlet var dropAreaView: UIImageView!
    @IBOutlet var slider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.orangeView.layer.cornerRadius = 10

        self.orangeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:))))
    }

    @IBAction func handleTap(_: UITapGestureRecognizer) {
        self.orangeView.center = self.dropAreaView.center
    }

    @IBAction func handleSliderChange() {
    }

    @IBAction func handleReset(_: Any) {
        self.view.window?.rootViewController = ExampleViewController()
    }

}
