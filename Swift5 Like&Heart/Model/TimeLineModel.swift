//
//  TimeLineModel.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/27.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import Foundation
import Firebase

class TimeLineModel {
    //送信分
    var text: String = ""
    //画像URL
    var imageString: String = ""
    var profileImageString: String = ""
    var userName: String = ""
    var likeCounts = 0
    var heartCounts = 0
    let ref: DatabaseReference!
    
    init(text: String, imageString: String, profileImageString: String, userName: String) {
        self.text = text
        self.imageString = imageString
        self.profileImageString = profileImageString
        self.userName = userName
        ref = Database.database().reference().child("timeLine").childByAutoId()
    }
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        if let value = snapshot.value as? [String: Any] {
            text = value["text"] as! String
            imageString = value["imageString"] as! String
            profileImageString = value["profileImageString"] as! String
            userName = value["userName"] as! String
            likeCounts = value["likeCounts"] as! Int
            heartCounts = value["heartCounts"] as! Int
        }
    }
    
    func toContents() -> [String: Any] {
        return
            ["text": text, "imageString": imageString, "profileImageString": profileImageString, "userName": userName, "likeCounts": likeCounts, "heartCounts": heartCounts]
    }
    
    func save() {
        ref.setValue(toContents())
    }

}

extension TimeLineModel {
    
    func plusLike() {
        likeCounts += 1
        ref.child("likeCounts").setValue(likeCounts)
    }
    
    func plusHeart() {
        heartCounts += 1
        ref.child("heartCounts").setValue(heartCounts)
    }
    
    func minusLike() {
        likeCounts -= 1
        ref.child("likeCounts").setValue(likeCounts)
    }
    
    func minusHeart() {
        heartCounts -= 1
        ref.child("heartCounts").setValue(heartCounts)
    }

}
