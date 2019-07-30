
import UIKit

class Post: NSObject {
    
    var titleArray: String!
    var descArray: String!
    var priorityArray: String!
    
    init(titleArray: String, descArray: String, priorityArray: String){
        
        self.titleArray = titleArray
        self.descArray = descArray
        self.priorityArray = priorityArray
        
    }

}
