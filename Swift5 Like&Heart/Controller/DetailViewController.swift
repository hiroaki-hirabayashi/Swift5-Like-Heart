//
//  DetailViewController.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/28.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    
    //受け取り用変数
    var profileImage = String()
    var userName = String()
    var contentImage = String()
    var likeCount = Int()
    var heartCount = Int()
    var comment = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
        userNameLabel.text = userName
        contentImageView.sd_setImage(with: URL(string: contentImage), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
        commentTextView.text = comment
        likeButton.setTitle("👍\(likeCount)いいね", for: [])
        heartButton.setTitle("💗\(heartCount)ハート", for: [])
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
