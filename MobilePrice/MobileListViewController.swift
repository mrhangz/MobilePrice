import UIKit

class MobileListViewController: UITableViewController {
    
    var mobiles: [Mobile]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.darkText], for: UIControlState.selected)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray], for: UIControlState.normal)
        
        getMobiles()
    }
    
    func getMobiles() {
        APIManager.shared.getMobiles { [weak self] (mobiles, error) in
            if let mobiles = mobiles {
                self?.mobiles = mobiles
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mobile = sender as? Mobile else {
            return
        }
        let destinationVC = segue.destination as! MobileDetailsViewController
        destinationVC.mobile = mobile
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as! MobileTableViewCell
        let cellViewModel = MobileCellViewModel(mobile: mobiles![indexPath.row])
        cell.displayCell(viewModel: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobiles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MobileDetails", sender: mobiles?[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: false)
    }
}
