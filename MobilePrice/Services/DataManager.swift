import Foundation

protocol DataManagerProtocol {
    func getFavourites(completion: @escaping (Set<Int>) -> Void)
    func setFavourites(favourites: Set<Int>)
}

class DataManager: DataManagerProtocol {
    static let shared: DataManager = DataManager()
    
    func getFavourites(completion: @escaping (Set<Int>) -> Void) {
        var favourites: Set<Int> = []
        if let data = UserDefaults.standard.object(forKey: "favourites") as? Data {
            favourites = NSKeyedUnarchiver.unarchiveObject(with: data) as! Set<Int>
        }
        completion(favourites)
    }
    
    func setFavourites(favourites: Set<Int>) {
        let data = NSKeyedArchiver.archivedData(withRootObject: favourites)
        UserDefaults.standard.set(data, forKey: "favourites")
        UserDefaults.standard.synchronize()
    }
}
