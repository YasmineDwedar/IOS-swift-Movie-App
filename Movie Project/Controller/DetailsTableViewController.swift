

import UIKit
import SDWebImage
import Cosmos
import youtube_ios_player_helper_swift
import Alamofire
import SwiftyJSON


class DetailsTableViewController: UITableViewController {

    var mobj:Movie!
    
  
    @IBOutlet weak var titlee: UILabel!
    
  
    @IBAction func seeReviews(_ sender: Any) {
        
        let rev :ReviewsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "reviewsVC") as! ReviewsTableViewController
        
        rev.objj = mobj
        
        self.navigationController?.pushViewController(rev, animated: true)
    }
    
    @IBOutlet weak var rateview: CosmosView!
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var releaseyear: UILabel!
    
    
    @IBOutlet weak var trailerView: YTPlayerView!
 
    @IBAction func fav(_ sender: UIButton) {
        
        var coredataObj = CoreDataMovies()
        coredataObj.addFav(movobj: mobj)
       
        let fav:FavouriteTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "favoriteVC") as! FavouriteTableViewController

        fav.favobj = mobj

         self.navigationController?.pushViewController(fav, animated: true)
    
    }
 
    @IBOutlet weak var overview: UITextView!
    
    var videosArr:[String]=[]
    var x:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        titlee.text = mobj.title!
        poster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/" + mobj.poster), placeholderImage: nil)
     //   print(mobj.rating!)
        releaseyear.text = mobj.releaseYear
        overview.text = mobj.overview
       rateview.rating = Double(mobj.rating )/2
       
        let idStr=String(mobj.id)
        Alamofire.request("https://api.themoviedb.org/3/movie/"+idStr+"/videos?api_key=1dd9ff50cd8ba034f7343b001d58d1a0").validate().responseJSON(){ response in
            if response.result.isSuccess{
                guard let data = response.result.value as? [String:Any] else { return}
                guard let json = data["results"] as? [Any] else{return}

                for i in 0 ... json.count-1
                {
                    let obj=json[i] as?[String:Any]
                    var id=obj?["key"] as? String;

                    if id==nil{id=""}

                    self.videosArr.append(id ?? "")
                    print("")
                   // print(id!)
                    self.tableView.reloadData()
                }
                self.tableView.reloadData()
                self.x=1
               // print(self.videosArr.count)
            }
            else{

                print("fails")

            }
            self.trailerView.load(videoId: self.videosArr[0])
    }

}
}
