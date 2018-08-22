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
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let reward = Reward(context: context)
        reward.name = nameTextField.text
        reward.image = UIImagePNGRepresentation(rewardImageView.image!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
