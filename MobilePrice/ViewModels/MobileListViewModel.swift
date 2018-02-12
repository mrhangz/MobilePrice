import Foundation

enum MobileSortingType {
    case priceHighToLow
    case priceLowToHigh
    case rating
}

enum ListType {
    case All
    case Favourite
}

class MobileListViewModel {
    var mobiles: [Mobile]?
    var favouriteIDs: Set<Int>!
    var listType: ListType = .All
    var apiManager: APIManagerProtocol!
    var dataManager: DataManagerProtocol!
    
    var displayingMobiles: [Mobile] = [Mobile]() {
        didSet {
            didUpdateMobiles?()
        }
    }
    
    var didUpdateMobiles: (() -> Void)?
    var displayMessage: ((String, String) -> Void)?
    
    init(apiManager: APIManagerProtocol = APIManager.shared, dataManager: DataManagerProtocol = DataManager.shared) {
        self.apiManager = apiManager
        self.dataManager = dataManager
        getFavourites()
        getMobiles()
    }
    
    func getFavourites() {
        dataManager.getFavourites { [weak self] (favourites) in
            self?.favouriteIDs = favourites
        }
    }
    
    func getMobiles() {
        apiManager.getMobiles { [weak self] (mobiles, error) in
            if let mobiles = mobiles {
                self?.mobiles = mobiles
                self?.displayingMobiles = mobiles
            } else {
                self?.displayMessage?("Sorry", "Something went wrong. Please try again.")
            }
        }
    }
    
    func changeListType(type: ListType) {
        self.listType = type
        switch type {
        case .All:
            displayingMobiles = mobiles ?? []
        default:
            displayingMobiles = (mobiles ?? []).filter({ favouriteIDs.contains($0.id!) })
        }
    }
    
    func sortMobiles(by type: MobileSortingType) {
        switch type {
        case .priceHighToLow:
            displayingMobiles = displayingMobiles.sorted(by: { (m1, m2) -> Bool in
                m1.price ?? 0 > m2.price ?? 0
            })
        case .priceLowToHigh:
            displayingMobiles = displayingMobiles.sorted(by: { (m1, m2) -> Bool in
                m1.price ?? 0 < m2.price ?? 0
            })
        case .rating:
            displayingMobiles = displayingMobiles.sorted(by: { (m1, m2) -> Bool in
                m1.rating ?? 0 > m2.rating ?? 0
            })
        }
    }
    
    func addMobileToFavourite(mobileID: Int) {
        favouriteIDs.insert(mobileID)
        dataManager.setFavourites(favourites: favouriteIDs)
    }
    
    func removeMobileFromFavourite(at index: Int) {
        let id = displayingMobiles[index].id!
        favouriteIDs.remove(id)
        displayingMobiles.remove(at: index)
        dataManager.setFavourites(favourites: favouriteIDs)
    }
    
    func isFavourite(index: Int) -> Bool {
        return favouriteIDs.contains(displayingMobiles[index].id!)
    }
    
    func isFavouriteList() -> Bool {
        return listType == .Favourite
    }
}
