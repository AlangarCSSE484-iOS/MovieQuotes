//
//  MovieQuotesTableViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 3/29/18.
//  Copyright © 2018 alangavr. All rights reserved.
//

import UIKit
//hi there...where does this commit to?


class MovieQuotesTableViewController: UITableViewController {
    
    let movieQuotesCellIdentifier = "MovieQuotesCell"
    let noMovieQuoteCellIdentifier = "NoMovieQuoteCell"
    let ShowDetailSegueIdentifier = "ShowDetailSegue"

    var movieQuotes = [MovieQuote]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddDialog))
        movieQuotes.append(MovieQuote(quote: "I'll be back!", movie: "Terminator"))
        movieQuotes.append(MovieQuote(quote: "I have a big head and little arms...I don't know how well this plan was thought through....", movie: "Meet the Robinsons"))
        
    }
    
    @objc func showAddDialog () {
        let alertController = UIAlertController(title: "Create a new movie quote", message: "HEYOOOO", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Quote"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Movie Title"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil)
        
        let createQuoteAction = UIAlertAction(title: "Create Quote", style: UIAlertActionStyle.default) { (action) in
            let quoteTextField = alertController.textFields![0]
            let movieTextField = alertController.textFields![1]
            print(quoteTextField.text!)
            print(movieTextField.text!)
            
            let movieQuote = MovieQuote(quote: quoteTextField.text!, movie: movieTextField.text!)
            self.movieQuotes.insert(movieQuote, at: 0)
            
            //we want animations!
            
            if (self.movieQuotes.count == 1) {
                self.tableView.reloadData()
                
            } else {
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.top)
                //no animations here
                // self.tableView.reloadData()
            }
        
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createQuoteAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if movieQuotes.count == 0 {
            super.setEditing(false, animated: animated)
        } else {
            super.setEditing(editing, animated: animated)
        }
    }
    
    // MARK: - Table view data source
    
    //(defaults to 1)
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return max(movieQuotes.count, 1)
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if movieQuotes.count == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: noMovieQuoteCellIdentifier, for: indexPath)
            return cell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: movieQuotesCellIdentifier, for: indexPath)
     
            // Configure the cell...
            cell.textLabel?.text = movieQuotes[indexPath.row].quote
            cell.detailTextLabel?.text = movieQuotes[indexPath.row].movie
            return cell
        }
     }
    
    
    
     // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return (movieQuotes.count > 0)
    }
    
    
    
     // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            movieQuotes.remove(at: indexPath.row)
            if (movieQuotes.count == 0){
                tableView.reloadData()
                self.setEditing(false, animated: true)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            print(movieQuotes)
        }
    }
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowDetailSegueIdentifier{
            if let indexPath = tableView.indexPathForSelectedRow{
                (segue.destination as! MovieQuoteDetailViewController).movieQuote =
                    movieQuotes[indexPath.row]
            }
            
        }
     }
 
    
}
