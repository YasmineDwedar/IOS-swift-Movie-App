

import UIKit
import SDWebImage
import CoreData

var moviearr:[Movie]!


class FavouriteTableViewController: UITableViewController {
  
 var favobj:Movie!
    var favoritesarray:[Movie] = []
 
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      //  self.tableView.reloadData()
//        let coredataobj = CoreDataMovies()
//     
//         favoritesarray = coredataobj.retrieveFav()
//             // self.tableView.reloadData()
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         //self.tableView.reloadData()
        let coredataobj = CoreDataMovies()
        
        favoritesarray = coredataobj.retrieveFav()
        self.tableView.reloadData()
    }
  

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
                return favoritesarray.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavCell


 cell.titfav.text = favoritesarray[indexPath.row].title
     
  cell.favimg.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/" + favoritesarray[indexPath.row].poster), placeholderImage: nil)
    
        print("tessssssssssttttttt")
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return
     130
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let m :DetailsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailVc") as! DetailsTableViewController
        
      // let title = favoritesarray[indexPath.row].valueForKey("title") as! String
        
         self.navigationController?.pushViewController(m, animated: true)
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            
            let id = favoritesarray[indexPath.row].id
            let coredataobj = CoreDataMovies()
            coredataobj.deleteFav(id:id!)
            
            favoritesarray.remove(at: indexPath.row)

       self.tableView.reloadData()
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
