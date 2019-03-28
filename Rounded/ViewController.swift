import UIKit

class ViewController: UIViewController {
    private let defaultRadius: CGFloat = 16.0

    @IBOutlet weak var staticImageView: UIImageView?
    @IBOutlet weak var staticUnderview: UIView?

    @IBOutlet weak var dynamicImageView: UIImageView?
    private var dynamicUnderview: UIView?

    override func viewDidLayoutSubviews() {
        setDropShadowsOnStaticView()
        setDropShadowsOnDynamicView()
    }

    func setDropShadowsOnStaticView() {
        setCornerRadiusAndDropShadow(radius: self.defaultRadius, view: staticImageView, underview: staticUnderview)
    }

    func setDropShadowsOnDynamicView() {
        guard let dynamicImageView = self.dynamicImageView,
              self.dynamicUnderview == nil
                else { return }

        dynamicUnderview = attachUnderview(to: dynamicImageView)

        setCornerRadiusAndDropShadow(radius: defaultRadius, view: dynamicImageView, underview: dynamicUnderview)
    }

    private func setCornerRadiusAndDropShadow(radius: CGFloat, view: UIImageView?, underview: UIView?) {
        setCornerRadius(of: radius, on: view)
        setCornerRadius(of: radius, on: underview, clipping: false)
        addDropShadow(to: underview)
    }

    func attachUnderview(to view: UIView?) -> UIView? {
        guard let view = view,
              let superview = view.superview
                else { return nil }

        let underView = UIView(frame: view.frame)
        // TODO make constraints work
        underView.translatesAutoresizingMaskIntoConstraints = false

        superview.insertSubview(underView, belowSubview: view)

        return underView
    }

    func setCornerRadius(of radius: CGFloat, on view: UIView?, clipping: Bool = true) {
        guard let view = view else { return }
        let layer = view.layer

        layer.cornerRadius = radius
        view.clipsToBounds = clipping
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
