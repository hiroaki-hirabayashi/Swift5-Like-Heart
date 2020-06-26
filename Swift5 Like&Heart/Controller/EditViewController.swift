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
    
    //imageViewをタップ出来る様にする　チェックを入れ、tapを配置
    @IBAction func tapImageView(_ sender: Any) {
        openActionSheet()
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
        
        
        
        performSegue(withIdentifier: "timeLine", sender: nil)
    }
    
    func sendAndGetImageURL() {
        /*
         DB: https://swift5-like-and-heart.firebaseio.com/
         Storage: gs://swift5-like-and-heart.appspot.com/
         */
        
        let ref = Database.database().reference(fromURL: "https://swift5-like-and-heart.firebaseio.com/")
        let storage = Storage.storage().reference(forURL: "gs://swift5-like-and-heart.appspot.com/")
        //画像が入るファイルを作成してそこに入れる
        //名前も決める
        let key = ref.childByAutoId().key
        let imageRef = storage.child("ProfileImage").child("\(key).jpeg")
        
        var imageData: Data = Data()
        //self.imageView.imageがnilじゃなかったら
        if self.imageView.image != nil {
            imageData = (self.imageView.image?.jpegData(compressionQuality: 0.03)) as! Data

        //アップロード
            let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                imageRef.downloadURL { (url, error) in
                    if url != nil {
                        //HUD
                        self.imageURL = url
                        UserDefaults.standard.set(self.imageURL?.absoluteString, forKey: "ProfileImageString")
                    }
                }
            }
            uploadTask.resume()

        }
        
        //キャンセル
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
        
        //画像が選択されたら
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           //info[.editedImage]がUIImageとしてpickedImageに入っていたら
            if let pickedImage = info[.editedImage] as? UIImage {
                self.imageView.image = pickedImage
                picker.dismiss(animated: true, completion: nil)
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
