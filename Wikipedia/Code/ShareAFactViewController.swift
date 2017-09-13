import UIKit

class ShareAFactViewController: UIViewController {

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var articleLicenseView: LicenseView!
    @IBOutlet weak var imageLicenseView: LicenseView!
    @IBOutlet weak var imageGradientView: WMFGradientView!

    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var imageViewLetterboxConstraints: [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        let theme = Theme.standard //always use the standard theme for now
        view.backgroundColor = theme.colors.paperBackground
        articleTitleLabel.textColor = theme.colors.primaryText
        separatorView.backgroundColor = theme.colors.border
        textLabel.textColor = theme.colors.primaryText
        articleLicenseView.tintColor = theme.colors.secondaryText
        imageLicenseView.tintColor = .white
        imageGradientView.setStart(.clear, end: UIColor(white: 0, alpha: 0.4))
    }
    
    public func update(with articleURL: URL, articleTitle: String?, text: String?, image: UIImage?, imageLicenseCodes: [String]) {
        view.semanticContentAttribute = MWLanguageInfo.semanticContentAttribute(forWMFLanguage: articleURL.wmf_language)
        textLabel.semanticContentAttribute = view.semanticContentAttribute
        articleTitleLabel.semanticContentAttribute = view.semanticContentAttribute
        
        imageView.image = image
        isImageViewHidden = image == nil
        textLabel.text = text
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        let width = isImageViewHidden ? view.bounds.size.width : round(0.5 * view.bounds.size.width)
        let size = textLabel.sizeThatFits(CGSize(width: width, height: view.bounds.size.height))
        if size.height > 0.6 * view.bounds.size.height {
            textLabel.font = UIFont.systemFont(ofSize: 14)
        }
        articleTitleLabel.text = articleTitle
        
        imageLicenseView.licenseCodes = imageLicenseCodes
        articleLicenseView.licenseCodes = ["cc", "by", "sa"]

        guard let image = image else {
            return
        }
        
        guard image.size.width > image.size.height else {
            return
        }

        backgroundImageView.image = image
        let aspect = image.size.height / image.size.width
        let height = round(imageViewWidthConstraint.constant * aspect)
        let remainder = round(0.5 * (view.bounds.size.height - height))
        for letterboxConstraint in imageViewLetterboxConstraints {
            letterboxConstraint.constant = remainder
        }
    }
    
    var isImageViewHidden: Bool = false {
        didSet {
            imageViewTrailingConstraint.constant = isImageViewHidden ? imageViewWidthConstraint.constant : 0
        }
    }


}
