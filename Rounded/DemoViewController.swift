import UIKit

class DemoViewController: UIViewController {

    private let defaultRadius: CGFloat = 16.0

    @IBOutlet weak var staticImageView: UIImageView?
    @IBOutlet weak var staticUnderview: UIView?

    @IBOutlet weak var dynamicImageView: UIImageView?
    private weak var dynamicUnderview: UIView?

    override func viewDidLayoutSubviews() {
        setDropShadowsOnStaticView()
        setDropShadowsOnDynamicView()
    }

    func setDropShadowsOnStaticView() {
        setCornerRadiusAndDropShadow(radius: defaultRadius, view: staticImageView, underview: staticUnderview)
    }

    func setDropShadowsOnDynamicView() {
        guard let dynamicImageView = self.dynamicImageView,
            self.dynamicUnderview == nil
            else { return }

        dynamicUnderview = attachUnderview(to: dynamicImageView)

        setCornerRadiusAndDropShadow(radius: defaultRadius, view: dynamicImageView, underview: dynamicUnderview)
    }
}
