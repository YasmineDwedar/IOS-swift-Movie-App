//
//  CoreDataMovies.swift
//  Movie Project
//
//  Created by MacOSSierra on 3/13/20.
//  Copyright © 2020 yasmine. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataMovies {
    
    //var apdel : AppDelegate?
   // var nsContext : NSManagedObjectContext?
//    init(apdel: AppDelegate) {
//        self.apdel = apdel
//        nsContext = apdel.persistentContainer.viewContext
//    }
    
    func savetoCoreData(moviearray:[Movie])-> Bool{
        var status:Bool = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext

               // let entity = NSEntityDescription.entity(forEntityName: "MovieDB", in: managedContext)!
        
              //let movie =     NSManagedObject(entity: entity, insertInto: managedContext)
        
                for i in 0..<[moviearray].count{
                  let movie = MovieDB(context: managedContext)
               
                movie.setValue(moviearray[i].id, forKey: "id")
                    movie.setValue(moviearray[i].overview, forKey: "overview")
                    movie.setValue(moviearray[i].rating, forKey: "rating")
                 movie.setValue(moviearray[i].poster, forKey: "poster")
                     movie.setValue(moviearray[i].releaseYear , forKey: "releaseYear")
                }
        
                do {
               try managedContext.save()
                status = true
                 } catch let error{
                    print(error)
        
                }
        
        return status
    }
    
    
    func getFromCoreData()-> [Movie]{
      
        var Listt = [Movie]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
     
        let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "MovieDB")
            //    let movie = MovieDB(context: managedContext)
        
        do {
       
            let moviearray  :[MovieDB] = try managedContext.fetch(fetchrequest) as! [MovieDB]
             for movieitem in moviearray
             {
                let mov = Movie()
                mov.id = movieitem.value(forKey:"id")  as? Int
                mov.title = movieitem.value(forKey:"title")! as? String
                mov.poster = movieitem.value(forKey:"poster")! as? String
                mov.rating = movieitem.value(forKey:"rating")! as? Float
                mov.overview = movieitem.value(forKey:"overview")! as? String
                mov.releaseYear = movieitem.value(forKey:"title")! as? String
                
                Listt.append(mov)
                
            }
           
        } catch let error  {
            print(error)
        }
  return Listt
    }

    func deleteFromCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchrequest)
        
        
        do {
            try managedContext.execute(batchDeleteRequest)
            
        } catch let error {
            print(error)
        }

    }
   
    func addFav(movobj: Movie){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteDB", in: managedContext)
        let movie = NSManagedObject(entity: entity!, insertInto: managedContext)
  
          movie.setValue(movobj.id, forKey: "id")
          movie.setValue(movobj.title, forKey: "title")
         movie.setValue(movobj.rating, forKey: "rating")
         movie.setValue(movobj.poster, forKey: "poster")
        movie.setValue(movobj.overview, forKey: "overview")
        movie.setValue(movobj.releaseYear, forKey: "releaseYear")
        
        do {
            try managedContext.save()
        } catch let error  {
            print(error)
        }
    }

    func retrieveFav() -> [Movie] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
         let fetchrequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteDB")
        
        
        var Listt = [Movie]()
       
        do {
            
            let moviearray  :[FavoriteDB] = try managedContext.fetch(fetchrequest) as! [FavoriteDB]
            for movieitem in moviearray
            {
                let mov = Movie()
                mov.id = movieitem.value(forKey:"id")  as? Int
                mov.title = movieitem.value(forKey:"title")! as? String
                mov.poster = movieitem.value(forKey:"poster")! as? String
                mov.rating = movieitem.value(forKey:"rating")! as? Float
                mov.overview = movieitem.value(forKey:"overview")! as? String
                mov.releaseYear = movieitem.value(forKey:"releaseYear")! as? String
                
                Listt.append(mov)
        
            }
            
        } catch let error  {
            print(error)
        }
        return Listt
    }
  
    func deleteFav(id :Int){
   
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "FavoriteDB", in: managedContext)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteDB")
        
        fetchRequest.entity = entity
        let mypredicate = NSPredicate(format: "id=%d", id)
        fetchRequest.predicate = mypredicate
        
        do{
            let res = try managedContext.fetch(fetchRequest)
            if (res.count > 0)
            {
                let manage = res[0] as! NSManagedObject
                managedContext.delete(manage)
                try managedContext.save()
            }
        }catch let error{
            print(error)
            }
        
        }
       
    }
 
    

