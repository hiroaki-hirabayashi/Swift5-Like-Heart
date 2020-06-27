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
    
    let normalLikeColor = UIColor.lightGray
    let normalHeartColor = UIColor.lightGray

    let tapLikeColor = UIColor.red
    let tapHeartColor = UIColor.red
    
    var tapLikeCount = 0
    var tapHeartCount = 0

    var animationView: AnimationView! = AnimationView()
    
    var timeLineModel: TimeLineModel! {
        didSet {
            commentLabel.text = timeLineModel.text
            commentLabel.sizeToFit()
            contentsImageView.sd_setImage(with: URL(string: timeLineModel.imageString), placeholderImage: UIImage(named: "noImage"), options: .continueInBackground, completed: nil)
            
            userNameLabel.text = timeLineModel.userName
            
            likeButton.setTitle("👍\(timeLineModel.likeCounts)いいね", for: [])
             heartButton.setTitle("💗\(timeLineModel.heartCounts)ハート", for: [])
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
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
