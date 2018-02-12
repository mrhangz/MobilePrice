import UIKit

class MobileListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var allButton: UIButton!
    @IBOutlet var favouriteButton: UIButton!
    
    var viewModel: MobileListViewModel!
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        viewModel = MobileListViewModel()
        viewModel.didUpdateMobiles = { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
        viewModel.displayMessage = { [weak self] title, subtitle in
            self?.displayMessage(title: title, subtitle: subtitle)
        }
    }
    
    @objc private func refresh() {
        viewModel?.getMobiles()
    }
    
    private func displayMessage(title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
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
    
    @IBAction func listTypeTapped(sender: UIButton) {
        if sender == favouriteButton {
            favouriteButton.isSelected = true
            allButton.isSelected = false
            viewModel.changeListType(type: .Favourite)
            tableView.refreshControl = nil
        } else {
            favouriteButton.isSelected = false
            allButton.isSelected = true
            viewModel.changeListType(type: .All)
            tableView.refreshControl = refreshControl
        }
    }
}

extension MobileListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as! MobileTableViewCell
        let cellViewModel = MobileCellViewModel(mobile: viewModel.displayingMobiles[indexPath.row], isFavourite: viewModel.isFavourite(index: indexPath.row), hideFavourite: viewModel.isFavouriteList())
        cellViewModel.delegate = self
        cell.displayCell(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.displayingMobiles.count
    }
}

extension MobileListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MobileDetails", sender: viewModel.displayingMobiles[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeMobileFromFavourite(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return viewModel.isFavouriteList() ? .delete : .none
    }
}

extension MobileListViewController: MobileTableViewCellDelegate {
    func addToFavourite(mobileID: Int) {
        viewModel.addMobileToFavourite(mobileID: mobileID)
    }
}
