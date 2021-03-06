//
//  MovieQuoteDetailViewController.swift
//  MovieQuotes
//
//  Created by CSSE Department on 4/17/18.
//  Copyright © 2018 alangavr. All rights reserved.
//

import UIKit
import Firebase

class MovieQuoteDetailViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    
    var movieQuoteRef: DocumentReference?
    var movieQuoteListener: ListenerRegistration!
    var movieQuote : MovieQuote?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(showEditDialog))

    }
    
    @objc func showEditDialog() {
        let alertController = UIAlertController(title: "Edit movie quote",
                                                message: "",
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Quote"
            textField.text = self.movieQuote?.quote
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Movie Title"
            textField.text = self.movieQuote?.movie
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        let editQuoteAction =  UIAlertAction(title: "Edit",
                                               style: .default) {
                                                (action) in
                                                let quoteTextField = alertController.textFields![0]
                                                let movieTextField = alertController.textFields![1]
                                                self.movieQuote?.quote = quoteTextField.text!
                                                self.movieQuote?.movie = movieTextField.text!
//                                                self.updateView()
                                                
                                                
                                                self.movieQuoteRef?.setData(self.movieQuote!.data)
                                                
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(editQuoteAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // updateView()
        movieQuoteListener = movieQuoteRef?.addSnapshotListener({ (docSnapshot, error) in
            if let error = error {
                print("Error getting the document: \(error.localizedDescription)")
            }
            if !docSnapshot!.exists {
                print("This document got deleted by someone else!")
            }
            self.movieQuote = MovieQuote(documentSnapshot: docSnapshot!)
            self.updateView()
            
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieQuoteListener.remove()
    }
    
    func updateView() {
        quoteLabel.text = movieQuote?.quote
        movieLabel.text = movieQuote?.movie
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
