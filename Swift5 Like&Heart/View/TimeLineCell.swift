//
//  TimeLineCell.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/27.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import Lottie


class TimeLineCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    var likeTapFlag = false
    var heartTapFlag = false
    var profileImageStringCheck = String()
    
    let normalLikeColor = UIColor.lightGray
    let normalHeartColor = UIColor.lightGray
    
    let tapLikeColor = UIColor.red
    let tapHeartColor = UIColor.red
    
    var animationView: AnimationView! = AnimationView()
    
    
    
    
    var timeLineModel: TimeLineModel! {
        didSet {
            //            commentLabel.text = timeLineModel.text
            //            commentLabel.sizeToFit()
            //            contentsImageView.sd_setImage(with: URL(string: timeLineModel.imageString), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
            //
            //            userNameLabel.text = timeLineModel.userName
            //
            //            likeButton.setTitle("👍\(timeLineModel.likeCounts)いいね", for: [])
            //             heartButton.setTitle("💗\(timeLineModel.heartCounts)ハート", for: [])
            //        }
            
            commentLabel.text = timeLineModel.text
            contentsImageView.sd_setImage(with:  URL(string: timeLineModel.imageString), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
            
            profileImageView.sd_setImage(with:  URL(string: timeLineModel.profileImageString), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
            
            userNameLabel.text = timeLineModel.userName
            
            if likeTapFlag == false && heartTapFlag == false{
                likeButton.setTitleColor(normalLikeColor, for: [])
                heartButton.setTitleColor(normalHeartColor, for: [])
                
            }else if (timeLineModel.likeCounts == 0 && timeLineModel.heartCounts == 0) && likeTapFlag == true && heartTapFlag == false{
                
                likeButton.setTitleColor(normalLikeColor, for: [])
                
                
            }else if (timeLineModel.likeCounts == 0 && timeLineModel.heartCounts == 0) && likeTapFlag == false && heartTapFlag == true{
                
                heartButton.setTitleColor(normalHeartColor, for: [])
                
                
            }else if likeTapFlag == true{
                likeButton.setTitleColor(tapLikeColor, for: [])
            }else if heartTapFlag == true{
                heartButton.setTitleColor(tapHeartColor, for: [])
            }
            
            print(timeLineModel.likeCounts)
            likeButton.setTitle("👍 \(timeLineModel.likeCounts)いいね", for: [])
            heartButton.setTitle("♡ \(timeLineModel.heartCounts)ハート", for: [])
            
            
        }
    }
    
    
}

func startLikeAnimation() {
    //jsonファイルを読み込んで作動させる
    let animation = Animation.named("good")
    animationView.animation = animation
    animationView.contentMode = .scaleAspectFit
    animationView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    animationView.loopMode = .playOnce
    animationView.backgroundColor = .clear
    self.addSubview(animationView)
    animationView.play()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        //2秒後に行いたい処理
        self.animationView.removeFromSuperview()
    }
}



    func startHeartAnimation() {
    //jsonファイルを読み込んで作動させる
    let animation = Animation.named("heart")
    animationView.animation = animation
    animationView.contentMode = .scaleAspectFit
    animationView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    animationView.loopMode = .playOnce
    animationView.backgroundColor = .clear
    self.addSubview(animationView)
    animationView.play()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        //2秒後に行いたい処理
        self.animationView.removeFromSuperview()
    }
}





@IBAction func likeButtonTap(_ sender: Any) {
    //        if tapLikeButtonCount == 0 && tapHeartButtonCount != 1 {
    //            timeLineModel.plusLike()
    //
    //            likeButton.setTitle("👍\(timeLineModel.likeCounts)いいね", for: [])
    //            tapLikeButtonCount = 1
    //            startLikeAnimation()
    //        } else if tapLikeButtonCount == 1 && tapLikeButtonCount != 0 {
    //            timeLineModel.minusLike()
    //            likeButton.setTitle("👍\(timeLineModel.likeCounts)いいね", for: [])
    //            likeButton.setTitleColor(normalLikeColor, for: [])
    //            tapLikeButtonCount = 0
    //        }
    if UserDefaults.standard.object(forKey: "profileImageString") != nil{
        
        profileImageStringCheck = UserDefaults.standard.object(forKey: "profileImageString") as! String
    }
    
    
    //自分のアカウント
    if profileImageStringCheck == timeLineModel.profileImageString{
        if likeTapFlag == false && heartTapFlag == false {
            timeLineModel.plusLike()
            likeButton.setTitle("👍 \(timeLineModel.likeCounts)いいね", for: [])
            likeButton.setTitleColor(tapLikeColor, for: [])
            startLikeAnimation()
            likeTapFlag = true
        }else if likeTapFlag == true && heartTapFlag == false {
            
            if timeLineModel.likeCounts == 0{
                
                likeButton.setTitle("👍 \(timeLineModel.likeCounts)いいね", for: [])
                timeLineModel.likeCounts += 1
                likeButton.setTitleColor(tapLikeColor, for: [])
                startLikeAnimation()
                likeTapFlag = true
                return
            }
            
            timeLineModel.minusLike()
            likeButton.setTitle("👍 \(timeLineModel.likeCounts)いいね", for: [])
            likeButton.setTitleColor(normalLikeColor, for: [])
            likeTapFlag = false
            
        }else{
            
            if likeTapFlag == false && heartTapFlag == false{
                
                
                timeLineModel.plusLike()
                likeButton.setTitle("👍 \(timeLineModel.likeCounts)いいね", for: [])
                likeButton.setTitleColor(tapLikeColor, for: [])
                startLikeAnimation()
                likeTapFlag = true
                
            }else if likeTapFlag == true && heartTapFlag == false{
                
                if timeLineModel.likeCounts == 0{
                    print(timeLineModel.likeCounts)
                    timeLineModel.likeCounts += 1
                    likeButton.setTitle("👍 \(timeLineModel.likeCounts)いいね", for: [])
                    likeButton.setTitleColor(tapLikeColor, for: [])
                    startLikeAnimation()
                    likeTapFlag = true
                    return
                }
                
                timeLineModel.minusLike()
                likeButton.setTitle("👍 \(timeLineModel.likeCounts)いいね", for: [])
                likeButton.setTitleColor(normalLikeColor, for: [])
                likeTapFlag = false
            }
            
            
            
        }
        
        
        
        
    }
    
    
    @IBAction func heartButtonTap(_ sender: Any) {
        //        if tapHeartButtonCount == 0 && tapLikeButtonCount != 1 {
        //            timeLineModel.plusHeart ()
        //
        //            heartButton.setTitle("💗\(timeLineModel.heartCounts)ハート", for: [])
        //            tapHeartButtonCount = 1
        //            startHeartAnimation()
        //        } else if tapHeartButtonCount == 1 && tapHeartButtonCount != 0 {
        //            timeLineModel.minusHeart()
        //            heartButton.setTitle("💗\(timeLineModel.heartCounts)ハート", for: [])
        //            heartButton.setTitleColor(normalHeartColor, for: [])
        //            tapHeartButtonCount = 0
        //        }
        //
        //    }
        //自分のアカウント
        if profileImageStringCheck == timeLineModel.profileImageString{
            
            if likeTapFlag == false && heartTapFlag == false{
                timeLineModel.plusHeart()
                heartButton.setTitle("♡ \(timeLineModel.heartCounts)ハート", for: [])
                heartButton.setTitleColor(tapHeartColor, for: [])
                startHeartAnimation()
                heartTapFlag = true
                
                
            }else if likeTapFlag == false && heartTapFlag == true{
                
                if timeLineModel.heartCounts == 0{
                    timeLineModel.plusHeart()
                    
                    heartButton.setTitle("♡ \(timeLineModel.heartCounts)ハート", for: [])
                    heartButton.setTitleColor(tapHeartColor, for: [])
                    
                    startHeartAnimation()
                    heartTapFlag = true
                    return
                }
                
                
                timeLineModel.minusHeart()
                heartButton.setTitle("♡ \(timeLineModel.heartCounts)ハート", for: [])
                heartButton.setTitleColor(normalHeartColor, for: [])
                heartTapFlag = false
            }else{
                
                
                if likeTapFlag == false && heartTapFlag == false{
                    
                    timeLineModel.plusHeart()
                    heartButton.setTitle("♡ \(timeLineModel.heartCounts)ハート", for: [])
                    heartButton.setTitleColor(tapHeartColor, for: [])
                    startHeartAnimation()
                    heartTapFlag = true
                }else if likeTapFlag == false && heartTapFlag == true {
                    
                    if timeLineModel.heartCounts == 0{
                        timeLineModel.plusHeart()
                        heartButton.setTitle("♡ \(timeLineModel.heartCounts)ハート", for: [])
                        heartButton.setTitleColor(tapHeartColor, for: [])
                        startHeartAnimation()
                        heartTapFlag = true
                        return
                    }
                    
                    timeLineModel.minusHeart()
                    heartButton.setTitle("♡ \(timeLineModel.heartCounts)ハート", for: [])
                    heartButton.setTitleColor(normalHeartColor, for: [])
                    heartTapFlag = false
                    
                }
                
                
                
            }
            
            
            
        }
        
        
    }
    
}
