//
//  SortByTableViewController.swift
//  EasyTox
//
//  Created by Satish Kumar R Kancherla on 8/1/16.
//  Copyright © 2016 Satish Kumar R Kancherla. All rights reserved.
//

import UIKit

protocol SortByDelegate {
    func sortBy(_ type:SortType)
}
class SortByTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var delegate:SortByDelegate?
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SortType.allValues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = SortType.allValues[(indexPath as NSIndexPath).row].rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.sortBy(SortType.allValues[(indexPath as NSIndexPath).row])
        self.dismiss(animated: true, completion: nil)
    }
}
