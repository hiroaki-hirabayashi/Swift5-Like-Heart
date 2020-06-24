//
//  EditViewController.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/25.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import Photos
import Firebase
import PKHUD

//アイコン設定画面
class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var imageURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status) {
            case .authorized:
                print("許可されています")
            case .denied:
                print("拒否されました")
            case.notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            default:
                fatalError()
            }
        }
    }
    
    func openActionSheet() {
        let alert: UIAlertController = UIAlertController(title: "選択してください", message: "", preferredStyle: .actionSheet)
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
