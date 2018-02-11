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
    
    init(name: String, price: Float, thumbImageURL: String, id: Int, brand: String, rating: Float, description: String) {
        self.name = name
        self.price = price
        self.thumbImageURL = thumbImageURL
        self.id = id
        self.brand = brand
        self.rating = rating
        self.description = description
    }
    
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
