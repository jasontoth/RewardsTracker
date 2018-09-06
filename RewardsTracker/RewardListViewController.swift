//
//  ViewController.swift
//  RewardsTracker
//
//  Created by Jason Toth on 8/21/18.
//  Copyright © 2018 Jason Toth. All rights reserved.
//

import UIKit

class RewardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var rewards : [Reward] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            rewards = try context.fetch(Reward.fetchRequest())
            tableView.reloadData()
        }
        catch {}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let reward = rewards[indexPath.row]
        cell.textLabel?.text = reward.name
        cell.imageView?.image = UIImage(data: reward.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reward = rewards[indexPath.row]
        performSegue(withIdentifier: "rewardSegue", sender: reward)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! RewardDetailViewController
        nextVC.reward = sender as? Reward
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let reward = rewards[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(reward)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                rewards = try context.fetch(Reward.fetchRequest())
                tableView.reloadData()
            }
            catch {}
        }
    }
}

