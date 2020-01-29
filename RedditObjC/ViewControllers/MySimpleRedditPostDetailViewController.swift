//
//  MySimpleRedditPostDetailViewController.swift
//  RedditObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MySimpleRedditPostDetailViewController: UIViewController {
    
    //MARK: - Properties
    var post: MySimpleRedditPost? 
    
    //MARK: - Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let post = post else { return }
        self.postTitleLabel.text = post.title
        MySimpleRedditPostController.sharedInstance().fetchImage(for: post) { (image) in
            DispatchQueue.main.async {
                self.postImageView.image = image
            }
        }
    }
}
