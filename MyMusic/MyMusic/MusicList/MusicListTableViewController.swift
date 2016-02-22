//
//  MusicListTableViewController.swift
//  MyMusic
//
//  Created by 赵亚琴 on 15/11/24.
//  Copyright © 2015年 赵亚琴. All rights reserved.
//

import UIKit

let identifier = "cell"

class MusicListTableViewController: UITableViewController {
    
    // 保存数据的数组
    var allDataArray:NSMutableArray?
    
    // 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicManager.shareManager().downLoadMusicWithURL(kMusicUrl) { (result) -> Void in
            self.allDataArray = NSMutableArray()
            self.allDataArray = result as? NSMutableArray
            self.tableView.reloadData()
            // 注册cell
            self.tableView.registerNib(UINib(nibName: "MusicListTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        }

        
//        SaveDataManager.shareManager()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.allDataArray?.count == nil {
            return 0
        }
        return (self.allDataArray?.count)!
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MusicListTableViewCell
//        
//        
//        
        let cell = MusicListTableViewCell.createCellWithTableView(tableView) as! MusicListTableViewCell
        cell.musicModel = self.allDataArray![indexPath.row] as? MusicModel
        
        return cell
    }
    
    // MARK: cell的高度
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    // MARK: 点击cell
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let playVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("playVC") as! MusicPlayViewController
        // 传值
        playVC.musicModel = self.allDataArray![indexPath.row] as? MusicModel
        playVC.index = indexPath.row
        
        self.navigationController?.pushViewController(playVC, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // 隐藏状态栏
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return UIStatusBarStyle.LightContent
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
