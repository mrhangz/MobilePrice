import Foundation
import ObjectMapper

struct Mobile: Mappable {
    
    var name: String?
    var price: Float?
    var thumbImageURL: String?
    var id: Int?
    var brand: String?
    var rating: Float?
    var description: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        price <- map["price"]
        thumbImageURL <- map["thumbImageURL"]
        id <- map["id"]
        brand <- map["brand"]
        rating <- map["rating"]
        description <- map["description"]
    }
}
