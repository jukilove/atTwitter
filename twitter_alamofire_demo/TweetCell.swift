//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var creatAtLabel: UILabel!
    
    @IBOutlet weak var retweentcountLabel: UILabel!
    
    @IBOutlet weak var favoritecountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            screennameLabel.text = "@\(tweet.user.screenName)"
            creatAtLabel.text = tweet.createdAtString
            
            retweentcountLabel.text = (String(tweet.retweetCount))
            favoritecountLabel.text = (String(describing:tweet.favoriteCount!))

            profileImageView.af_setImage(withURL: tweet.user.profileImage!)
            
            if(tweet.favorited)! {
                favoriteButton.setImage(#imageLiteral(resourceName:"favor-icon-red"), for: .normal)
            } else {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
            
            if(tweet.retweeted) {
                retweetButton.setImage(#imageLiteral(resourceName:"retweet-icon-green"), for: .normal)
            } else {
                retweetButton.setImage(#imageLiteral(resourceName:"retweet-icon"), for: .normal)
            }
            
        }
    }
    
    
    @IBAction func onFavorite(_ sender: Any) {
        if(tweet.favorited == false){
            tweet.favorited = true
            tweet.favoriteCount! += 1
            favoritecountLabel.text = "\(tweet.favoriteCount!)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        else{
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            favoritecountLabel.text = "\(tweet.favoriteCount!)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            })
        }
    }
    
    
    
    @IBAction func onRetweet(_ sender: Any) {
        if(tweet.retweeted == false){
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweentcountLabel.text = "\(tweet.retweetCount)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            APIManager.shared.retweet(tweet, completion: { (tweet, error) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeting the following Tweet: \n\(tweet.text)")
                }
            })
        }
        else{
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweentcountLabel.text = "\(tweet.retweetCount)"
            (sender as! UIButton).setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            APIManager.shared.unretweet(tweet, completion: { (tweet, error) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            })
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
