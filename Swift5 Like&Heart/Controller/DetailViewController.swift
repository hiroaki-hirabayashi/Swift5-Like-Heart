//
//  DetailViewController.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/28.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    
    var profileImage = String()
    var userName = String()
    var contentImage = Int()
    var likeCount = Int()
    var heartCount = Int()
    var comment = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
