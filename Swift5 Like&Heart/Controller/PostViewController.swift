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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: "profileImageString") != nil {
            profileImageString = UserDefaults.standard.object(forKey: "profileImageString") as! String
        }
        
        if userName != nil {
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            
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
        let imageRef = storage.child("ImageContents").child("\(key).jpeg")
        
        var imageData: Data = Data()
        //self.contentImageView.imageがnilじゃなかったら
        if self.contentImageView.image != nil {
            imageData = (self.contentImageView.image?.jpegData(compressionQuality: 0.03)) as! Data
            
        //HUD
            HUD.dimsBackground = false
            HUD.show(.progress)
        
        //アップロード
            let uploadTask = imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                imageRef.downloadURL { (url, error) in
                    if url != nil {
                        //HUD
                        HUD.hide()
                        self.imageURL = url
                        //送信ボタンを押せるようにする
                        self.postBarButtonItem.isEnabled = true
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
                self.contentImageView.image = pickedImage
                sendAndGetImageURL()
                
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tapImageView(_ sender: Any) {
        openActionSheet()
    }
    
    @IBAction func postContentToDatabase(_ sender: Any) {
        if commentTextView.text != "" && imageURL?.absoluteString.isEmpty != true {
            let timeLineModel = TimeLineModel(text: commentTextView.text, imageString: imageURL!.absoluteString, profileImageString: profileImageString, userName: userName)
            
            timeLineModel.save()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //タップで画面を閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        commentTextView.resignFirstResponder()
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
