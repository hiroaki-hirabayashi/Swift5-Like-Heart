//
//  LoginViewController.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/23.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //一回だけ呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //毎回呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
