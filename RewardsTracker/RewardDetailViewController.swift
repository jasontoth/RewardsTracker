//
//  RewardDetailViewController.swift
//  RewardsTracker
//
//  Created by Jason Toth on 8/22/18.
//  Copyright © 2018 Jason Toth. All rights reserved.
//

import UIKit

class RewardDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var rewardImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var reward : Reward? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if reward != nil {
            rewardImageView.image = UIImage(data: reward!.image as! Data)
            nameTextField.text = reward!.name
            
            saveButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }

    }
    
    @IBAction func addExistingPhoto(_ sender: Any) {
        
        // Give image picker the ability to source data from saved photos
        imagePicker.sourceType = .photoLibrary
        
        // Present the user with a dialog where they can select existing photos
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image from the input
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set selected image as the image in rewardImageView
        rewardImageView.image = image
        
        // Dismiss the select photos dialog and go back to reward detail screen
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewPhoto(_ sender: Any) {
    }
    
    @IBAction func saveReward(_ sender: Any) {
        
        if reward != nil {
            reward!.name = nameTextField.text
            reward!.image = UIImagePNGRepresentation(rewardImageView.image!)
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let newReward = Reward(context: context)
            newReward.name = nameTextField.text
            newReward.image = UIImagePNGRepresentation(rewardImageView.image!)
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteReward(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(reward!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
