//
//  LinksTableViewController.swift
//  IdeaEx
//
//  Created by Надежда Возна on 30.11.2019.
//  Copyright © 2019 Надежда Возна. All rights reserved.
//

import UIKit
import CoreData

class LinksTableViewController: UITableViewController {
    
    private var arrayOfLinks = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Links")
        do {
            arrayOfLinks = try context.fetch(fetch)
            tableView.reloadData()
        } catch {
            print("Error")
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #if DEBUG
        print("arrayOfLinks.count \(arrayOfLinks.count)")
        #endif
        return arrayOfLinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linksCell", for: indexPath)
        #if DEBUG
        print("arrayOfLinks: \(arrayOfLinks)")
        #endif
        cell.textLabel?.text = arrayOfLinks[indexPath.row].value(forKeyPath: "link") as? String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let web = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        web.urlString = cell?.textLabel?.text
        self.navigationController?.pushViewController(web, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
