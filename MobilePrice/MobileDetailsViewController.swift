import UIKit

class MobileDetailsViewController: UIViewController {
    
    var mobile: Mobile!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        self.navigationItem.title = mobile.name
        self.descriptionTextView.text = mobile.description
        self.priceLabel.text = "Price: $\(mobile.price ?? 0)"
        self.ratingLabel.text = "Rating: \(mobile.rating ?? 0)"
    }
}
