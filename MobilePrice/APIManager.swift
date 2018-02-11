import Foundation
import Alamofire
import SwiftyJSON

class APIManager {
    static let shared: APIManager = APIManager()
    
    func getMobiles(completion: @escaping ([Mobile]?, Error?) -> Void) {
        Alamofire.request("https://scb-test-mobile.herokuapp.com/api/mobiles/", encoding: JSONEncoding.default)
            .validate()
            .responseJSON {
                response in
                switch response.result {
                case .success(let value):
                    let array = JSON(value)
                    var mobiles: [Mobile] = []
                    for json in array.arrayValue {
                        if let mobile = Mobile(JSON: json.dictionaryObject!) {
                            mobiles.append(mobile)
                        }
                    }
                    completion(mobiles, nil)
                case .failure(let error):
                    completion(nil , error)
                }
        }
    }
    
    func getImages(for mobileID: Int, completion: @escaping () -> Void) {
        
    }
}
