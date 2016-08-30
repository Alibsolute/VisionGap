//
//  ViewController.swift
//  VisionGap
//
//  Created by absolute on 16/8/30.
//  Copyright © 2016年 Absolute. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray:NSMutableArray = NSMutableArray()
    var once:dispatch_once_t = 0
    var lastPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        for index in 1...9 {
            let image:UIImage = UIImage(named: "\(index).jpg")!
            self.dataArray.addObject(image);
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        dispatch_once(&once) { 
            tableView.registerNib(UINib(nibName: "MyTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CELL")
        }
        let cell:MyTableViewCell = tableView.dequeueReusableCellWithIdentifier("CELL", forIndexPath: indexPath) as! MyTableViewCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 9 / 16 * UIScreen.mainScreen().bounds.size.width
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell:MyTableViewCell = cell as! MyTableViewCell
        cell.coverImageView.image = self.dataArray[indexPath.row] as? UIImage
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var directionStr:String = ""
        if lastPoint.y > scrollView.contentOffset.y {
            directionStr = "Up"
        } else if lastPoint.y < scrollView.contentOffset.y {
            directionStr = "Down"
        }
        lastPoint = scrollView.contentOffset
        NSNotificationCenter.defaultCenter().postNotificationName("ScrollViewAnimation", object: directionStr)
        
    }
    
}

