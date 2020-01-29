//
//  MySimpleRedditPostTableViewCell.swift
//  RedditObjC
//
//  Created by Uzo on 1/28/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class MySimpleRedditPostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var post: MySimpleRedditPost? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - OUTLETS
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postUpCountLabel: UILabel!
    @IBOutlet weak var postCommentCountLabel: UILabel!
    
    
    func updateViews() {
        guard let post = post else { return }
        postTitleLabel.text = post.title
        postUpCountLabel.text = "Likes: \(post.ups)"
        postCommentCountLabel.text = "Number of Comments: \(post.commentCount)"
    }

}
