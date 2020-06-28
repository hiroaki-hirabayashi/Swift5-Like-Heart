//
//  PostViewController.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/28.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    
    var imageURL: URL?
    var profileImageString = ""
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Like&Heart"
        //最初は送信ボタンは使えないようにする
        postBarButtonItem.isEnabled = false
        commentTextView.text = ""
        commentTextView.becomeFirstResponder()

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
