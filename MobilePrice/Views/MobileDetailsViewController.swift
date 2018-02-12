import UIKit

class MobileDetailsViewController: UIViewController {
    
    var viewModel: MobileDetailsViewModel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = viewModel.mobileName()
        self.descriptionTextView.text = viewModel.mobileDescription()
        self.priceLabel.text = viewModel.priceText()
        self.ratingLabel.text = viewModel.ratingText()
        viewModel.didSetImages = { [weak self] in
            self?.collectionView.reloadData()
        }
        viewModel.displayMessage = { [weak self] title, subtitle in
            self?.displayMessage(title: title, subtitle: subtitle)
            self?.collectionView.backgroundColor = UIColor.lightGray
        }
    }
    
    private func displayMessage(title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension MobileDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mobileImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! MobileImageCollectionViewCell
        let cellViewModel = MobileImageCellViewModel(mobileImage: viewModel.mobileImages[indexPath.row])
        cell.displayCell(viewModel: cellViewModel)
        return cell
    }
}

extension MobileDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.height, height: self.collectionView.frame.size.height)
    }
}
