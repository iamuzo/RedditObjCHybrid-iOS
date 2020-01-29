//
//  MySimpleRedditPostsSearchTableViewController.swift
//  RedditObjC
//
//  Created by Uzo on 1/28/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MySimpleRedditPostsSearchTableViewController: UITableViewController {
    
    // MARK: - Properties
    var posts: [MySimpleRedditPost] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var mySimpleRedditPostsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySimpleRedditPostsSearchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? MySimpleRedditPostTableViewCell else {return UITableViewCell() }

        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayPostDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destination = segue.destination as? MySimpleRedditPostDetailViewController else { return }
            
            let selectedPost = self.posts[indexPath.row]
            destination.post = selectedPost
        }
    }
}


extension MySimpleRedditPostsSearchTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        MySimpleRedditPostController.sharedInstance().searchForPost(withSearchTerm: searchTerm) { (posts, error) in
            if (error != nil) {
                guard let error = error else {return }
                print("there was an error retrieving posts: ", error.localizedDescription)
            } else {
                self.posts = posts
                DispatchQueue.main.async {
                    self.title = searchTerm
                }
            }
        }
    }
}
