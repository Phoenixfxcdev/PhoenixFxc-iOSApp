//
//  FirstViewController.swift
//  PhoenixFxcApp
//
//  Created by Mauro A on 08/11/2016.
//  Copyright © 2016 PhoenixFxc. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, NSXMLParserDelegate {
    // MARK: Properties
    @IBOutlet var uiNewsTable: UITableView!
    @IBOutlet weak var uiCommentLabel: UILabel!
    //
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    let NEWS_SOURCE = "http://images.apple.com/main/rss/hotnews/hotnews.rss"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from
        
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:NEWS_SOURCE))!)!
        parser.delegate = self
        parser.parse()
        uiNewsTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("item") {
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date")
            }
            
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("title") {
            title1.appendString(string)
        } else if element.isEqualToString("pubDate") {
            date.appendString(string)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        if(cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
        }
        cell.textLabel?.text = String(posts.objectAtIndex(indexPath.row).valueForKey("title"))
        cell.detailTextLabel?.text = String(posts.objectAtIndex(indexPath.row).valueForKey("date"))
        return cell as UITableViewCell
    }
    
}

