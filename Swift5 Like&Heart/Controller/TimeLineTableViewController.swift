//
//  TimeLineTableViewController.swift
//  Swift5 Like&Heart
//
//  Created by 平林宏淳 on 2020/06/26.
//  Copyright © 2020 Hiroaki_Hirabayashi. All rights reserved.
//

import UIKit
import Firebase

class TimeLineTableViewController: UITableViewController {

    var timeLineRef = Database.database().reference().child("timeLine")
    var timeLines = [TimeLineModel]()
    var text = ""
    var userName = ""
    var profileImageString = ""
    var imageString = ""
    var likeCounts = Int()
    var heartCounts = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ナビバーを表示させたまま
        self.navigationController?.navigationBar.isHidden = false
        //戻るボタンを消す
        self.navigationItem.hidesBackButton = true
        //タップ可能にする
        self.tableView.allowsSelection = true
        title = "Like&Heart"
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //コンテンツを受信する
        timeLineRef.observe(.value) { (snapshot) in
            //全て除去
            self.timeLines.removeAll()
            for child in snapshot.children {
                let childSnapshot = child as! DataSnapshot
                let timeline = TimeLineModel(snapshot: childSnapshot)
                print(timeline)
                self.timeLines.insert(timeline, at: 0)
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    //セクションの数
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //セルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timeLines.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TimeLineCell
        let timeLineModel = timeLines[indexPath.row]
        cell.timeLineModel = timeLineModel
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileImageString = timeLines[indexPath.row].profileImageString
        userName = timeLines[indexPath.row].userName
        imageString = timeLines[indexPath.row].imageString
        likeCounts = timeLines[indexPath.row].likeCounts
        heartCounts = timeLines[indexPath.row].heartCounts
        text = timeLines[indexPath.row].text
        
        performSegue(withIdentifier: "detailViewController", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailViewController" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.profileImage = profileImageString
            detailViewController.userName = userName
            detailViewController.contentImage = imageString
            detailViewController.likeCount = likeCounts
            detailViewController.heartCount = heartCounts
            detailViewController.comment = text
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
