import UIKit

class MobileListViewController: UITableViewController {
    
    var viewModel: MobileListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.darkText], for: UIControlState.selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray], for: UIControlState.normal)
        
        viewModel = MobileListViewModel()
        viewModel.didUpdateMobiles = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func sortTapped(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
        let ascPriceAction = UIAlertAction(title: "Price low to high", style: .default) { [weak self] action in
            self?.viewModel.sortMobiles(by: .priceLowToHigh)
        }
        let descPriceAction = UIAlertAction(title: "Price high to low", style: .default) { [weak self] action in
            self?.viewModel.sortMobiles(by: .priceHighToLow)
        }
        let ratingAction = UIAlertAction(title: "Rating", style: .default) { [weak self] action in
            self?.viewModel.sortMobiles(by: .rating)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { alert in
            
        }
        alertController.addAction(ascPriceAction)
        alertController.addAction(descPriceAction)
        alertController.addAction(ratingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mobile = sender as? Mobile else {
            return
        }
        let destinationVC = segue.destination as! MobileDetailsViewController
        let destinationVM = MobileDetailsViewModel(mobile: mobile)
        destinationVC.viewModel = destinationVM
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as! MobileTableViewCell
        let cellViewModel = MobileCellViewModel(mobile: viewModel.displayingMobiles[indexPath.row], isFavourite: viewModel.isFavourite(index: indexPath.row))
        cellViewModel.delegate = self
        cell.displayCell(viewModel: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayingMobiles.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MobileDetails", sender: viewModel.displayingMobiles[indexPath.row])
    }
}

extension MobileListViewController: MobileTableViewCellDelegate {
    func addToFavourite(mobileID: Int) {
        viewModel.addMobileToFavourite(mobileID: mobileID)
    }
}
