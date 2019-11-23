//
//  ViewController.swift
//  DynamicSizeVC
//
//  Created by Neil Jain on 11/23/19.
//  Copyright © 2019 NeilsUltimateLab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: [String] = [
        "Returns the optimal size of the view based on its current constraints.",
        "The size that you prefer for the view. To obtain a view that is as small as possible, specify the constant layoutFittingCompressedSize. To obtain a view that is as large as possible, specify the constant layoutFittingExpandedSize.",
        "This method returns a size value for the view that optimally satisfies the view's current constraints and is as close to the value in the targetSize parameter as possible. This method does not actually change the size of the view.",
        "Storyboards in Interface Builder by default use size classes. Size classes are traits assigned to user interface elements, like scenes or views. They provide a rough indication of the element’s size. Interface Builder lets you customize many of your layout’s features based on the current size class. The layout then automatically adapts as the size class changes.",
        "When the system loads a scene, it instantiates all the views, controls, and constraints, and assigns these items to the appropriate outlet in the view controller (if any). You can access any of these items through their outlets, regardless of the scene’s current size class. However, the system adds these items to the view hierarchy only if they are installed for the current size class.",
        "Storyboards in Interface Builder by default use size classes. Size classes are traits assigned to user interface elements, like scenes or views. They provide a rough indication of the element’s size. Interface Builder lets you customize many of your layout’s features based on the current size class. The layout then automatically adapts as the size class changes.When the system loads a scene, it instantiates all the views, controls, and constraints, and assigns these items to the appropriate outlet in the view controller (if any). You can access any of these items through their outlets, regardless of the scene’s current size class. However, the system adds these items to the view hierarchy only if they are installed for the current size class.When the system loads a scene, it instantiates all the views, controls, and constraints, and assigns these items to the appropriate outlet in the view controller (if any). You can access any of these items through their outlets, regardless of the scene’s current size class. However, the system adds these items to the view hierarchy only if they are installed for the current size class.When the system loads a scene, it instantiates all the views, controls, and constraints, and assigns these items to the appropriate outlet in the view controller (if any). You can access any of these items through their outlets, regardless of the scene’s current size class. However, the system adds these items to the view hierarchy only if they are installed for the current size class."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.dataSource[indexPath.row]
        let vc = NotificationVC.initialize(for: item)
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = dataSource[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
}
