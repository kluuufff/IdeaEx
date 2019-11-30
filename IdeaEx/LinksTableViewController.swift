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
        print("arrayOfLinks.count \(arrayOfLinks.count)")
        return arrayOfLinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "linksCell", for: indexPath)
        print("arrayOfLinks: \(arrayOfLinks)")
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
    
    // MARK: - Navigation

//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueWebView" {
//            guard let destinationVC = segue.destination as? WebViewController else { return }
//            destinationVC.urlString = urlString
//            print("destinationVC.urlString \(destinationVC.urlString)")
//        }
//    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
