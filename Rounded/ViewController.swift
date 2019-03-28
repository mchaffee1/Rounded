import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var staticImageView: UIImageView?
    @IBOutlet weak var staticUnderview: UIView?

    @IBOutlet weak var dynamicImageView: UIImageView?
    private var dynamicUnderview: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setCornerRadius(on: staticImageView)
        setCornerRadius(on: staticUnderview, clipping: false)
        addDropShadow(to: staticUnderview)
    }

    override func viewDidLayoutSubviews() {
        guard dynamicUnderview == nil else { return }

        dynamicUnderview = attachUnderview(to: dynamicImageView)
        setCornerRadius(on: dynamicImageView)
        setCornerRadius(on: dynamicUnderview, clipping: false)
        addDropShadow(to: dynamicUnderview)
    }

    func setCornerRadius(on view: UIView?, clipping: Bool = true) {
        guard let view = view else { return }
        let layer = view.layer

        layer.cornerRadius = 16.0
        view.clipsToBounds = clipping
    }

    func attachUnderview(to view: UIView?) -> UIView? {
        guard let view = view,
            let superview = view.superview
            else { return nil }

        let underView = UIView(frame: view.frame)
        underView.translatesAutoresizingMaskIntoConstraints = false

        superview.insertSubview(underView, belowSubview: view)

        return underView
    }

    func addDropShadow(to view: UIView?) {
        guard let view = view else { return }
        let layer = view.layer

        layer.shadowPath =
            UIBezierPath(roundedRect: view.bounds,
                         cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 1
        layer.masksToBounds = false
    }
}
