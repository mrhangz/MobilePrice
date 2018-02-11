import UIKit

class MobileDetailsViewController: UIViewController {
    
    var mobile: Mobile!
    var images: [MobileImage]?
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        self.navigationItem.title = mobile.name
        self.descriptionTextView.text = mobile.description
        self.priceLabel.text = "Price: $\(mobile.price ?? 0)"
        self.ratingLabel.text = "Rating: \(mobile.rating ?? 0)"
        APIManager.shared.getImages(for: mobile.id!) { [weak self] (images, error) in
            if let images = images {
                self?.images = images
                self?.collectionView.reloadData()
            }
        }
    }
}

extension MobileDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! MobileImageCollectionViewCell
        let cellViewModel = MobileImageCellViewModel(mobileImage: images![indexPath.row])
        cell.imageView.sd_setImage(with: cellViewModel.imageURL)
        return cell
    }
}

extension MobileDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.height, height: self.collectionView.frame.size.height)
    }
}
