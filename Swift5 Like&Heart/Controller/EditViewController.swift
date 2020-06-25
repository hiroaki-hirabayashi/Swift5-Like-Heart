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
        //許可画面
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status) {
            case .authorized:
                print("許可されています。")
            case .denied:
                print("拒否されました。")
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
        let alert: UIAlertController = UIAlertController(title: "選択してください。", message: "", preferredStyle: .actionSheet)
        
       //カメラアクションが選択された時、以下が呼ばれる
        let cameraAction: UIAlertAction = UIAlertAction(title: "カメラから", style: .default) { (alert) in
            
            let sourceType = UIImagePickerController.SourceType.camera
            //もしカメラが使えるなら
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraPicker = UIImagePickerController()
                cameraPicker.delegate = self
                cameraPicker.sourceType = sourceType
                cameraPicker.allowsEditing = true
                //カメラを出す
                self.present(cameraPicker, animated: true, completion:  nil)
            } else {
                print("エラーです。")
            }
        }
        
        //アルバムアクション
        let albumAction: UIAlertAction = UIAlertAction(title: "アルバムから", style: .default) { (alert) in
            
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            //もしカメラが使えるなら
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let albumPicker = UIImagePickerController()
                albumPicker.delegate = self
                albumPicker.sourceType = sourceType
                albumPicker.allowsEditing = true
                //カメラを出す
                self.present(albumPicker, animated: true, completion:  nil)
            } else {
                print("エラーです。")
            }
        }
        
        //キャンセルアクション
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default) { (alert) in
            print("キャンセルされました。")
        }
        
        alert.addAction(cameraAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func done(_ sender: Any) {
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
