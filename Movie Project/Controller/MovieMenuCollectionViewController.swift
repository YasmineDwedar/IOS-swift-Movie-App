



import UIKit
import SDWebImage
import CoreData
import Alamofire
import  SwiftyJSON


private let reuseIdentifier = "Cell"

class MovieMenuCollectionViewController: UICollectionViewController,DataDisplay {

    var movie = Movie()
    var results = [Movie]()
    
    
    func fetchData(movieArr: [Movie]) {
        results = movieArr
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Net = Network(displayRef: self)
        Net.getData()
      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! MovieCollectionViewCell
   
        cell.imgPoster.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w185/" + results[indexPath.row].poster), placeholderImage: nil)
        cell.posterLbl.text = results[indexPath.row].title
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mov :DetailsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailVc") as! DetailsTableViewController
        
     
        print(results[indexPath.row])
        mov.mobj = results[indexPath.row]
        print("look here")
        print(mov.mobj!)
        
        self.navigationController?.pushViewController(mov, animated: true)
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    


}
