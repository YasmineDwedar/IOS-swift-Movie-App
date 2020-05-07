//
//  ReviewsTableViewController.swift
//  Movie Project
//
//  Created by MacOSSierra on 3/15/20.
//  Copyright © 2020 yasmine. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ReviewsTableViewController: UITableViewController {

     var reviewlist = [Content]()
   
    var objj:Movie!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let idStr=String(objj.id)
         print("reviews ids  "+idStr)
        
        var url:String = "https://api.themoviedb.org/3/movie/"+idStr+"/reviews?api_key=1dd9ff50cd8ba034f7343b001d58d1a0"
       Alamofire.request(url,method:.get).responseJSON
            
            { response in
                
           
                var json = JSON(response.result.value!)
                
                //print(json)
               for i in 0..<json["results"].count{

                     let con = Content()
               con.content = json["results"][i]["content"].stringValue
                con.author =  json["results"][i]["author"].stringValue
           
                self.reviewlist.append(con)
                print("the list reviews coming ")
                print("tot arr count")
                print(self.reviewlist.count)
                print(self.reviewlist[i].content!)
           
              }
                
                print("tot arr count")
                print(self.reviewlist.count)
             
               if(self.reviewlist.count == 0){
                 //  self.flag = 0
                    print("no reviewws for this movie ")
        
                }
                    self.tableView.reloadData()
   
    }
     self.tableView.reloadData()
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (reviewlist.count == 0)    {
            return 1
            
        }
     
    else{
        return reviewlist.count
    }
}

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celll", for: indexPath)
 
        if(reviewlist.count > 0 ) {
            
            print("testtttttttttttttttttt")
          print(reviewlist.count)
            cell.textLabel!.text = reviewlist[indexPath.row].content
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
         
            
        }
        
        else{
          
           
            cell.textLabel!.text = "NO REVIEWS FOR THIS MOVIE"
         
        }
    
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return
        UITableView.automaticDimension
    
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
