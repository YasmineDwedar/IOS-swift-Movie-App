

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class Network {
    // Array of objects 
    var movielist = [Movie]()
    var displayRef : DataDisplay
    
    init(displayRef : DataDisplay) {
        self.displayRef = displayRef
    }
    
   // Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity. desc&api_key=0f6963deb33263bc64efce4c7b4345a5").validate().responseJSON
    var url:String="https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=1dd9ff50cd8ba034f7343b001d58d1a0"
    
    func getData()  {
        Alamofire.request(url,method:.get).responseJSON
            
            { response in
                
                
                var json:JSON=JSON(response.result.value!)
                
                  //    let json  dataJSON(response.data)
              //print(json)
                
                for i in 0..<json["results"].count{
                    let mov = Movie()
                    mov.poster = json["results"][i]["poster_path"].stringValue
                    mov.title = json["results"][i]["title"].stringValue
                    mov.id = json["results"][i]["id"].intValue
                    mov.rating = json["results"][i]["vote_average"].floatValue
                    mov.overview = json["results"][i]["overview"].stringValue
                    mov.releaseYear = json["results"][i]["release_date"].stringValue
                    
                    //append in Array
                    self.movielist.append(mov)
                }
                //delegates the movielist the collection view 
                self.displayRef.fetchData(movieArr: self.movielist)
        }
    }
  
        
}

