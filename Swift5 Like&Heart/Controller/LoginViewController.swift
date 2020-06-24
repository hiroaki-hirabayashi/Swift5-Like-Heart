//
//  LoginViewController.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/23.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    //一回だけ呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //常時表示状態
        userNameView.isHidden = false

    }
    
    //毎回呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func done(_ sender: Any) {
        //textFieldの値をアプリ内に保存
        //textFieldのtextが空でない場合　isEnpty(空だったら)
        //入力されていたら
        if textField.text?.isEmpty != true {
            userNameView.isHidden = true
            UserDefaults.standard.set(textField.text, forKey: "userName")
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            print("振動")
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        //匿名ログイン
        Auth.auth().signInAnonymously { (result, error) in
            //errorが無かったら
            if error == nil {
                self.performSegue(withIdentifier: "edit", sender: nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        
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
