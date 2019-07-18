//
//  PostViewController.swift
//  Instagram
//
//  Created by macbook on 7/16/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import Parse


class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imageToPost: UIImageView!
    
    
    @IBAction func chooseImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            imageToPost.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func postImage(_ sender: Any) {
        
        if let image = imageToPost.image {
            
            let post = PFObject(className: "Post")
            
            post["message"] = comment.text
            
            post["userid"] = PFUser.current()?.objectId
            
            if let imageData = UIImage.pngData(image)() {
                
                let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                
                activityIndicator.center = self.view.center
                
                activityIndicator.hidesWhenStopped = true
                
                activityIndicator.style = UIActivityIndicatorView.Style.gray
                
                view.addSubview(activityIndicator)
                
                activityIndicator.startAnimating()
                
                UIApplication.shared.beginIgnoringInteractionEvents()
                
                
                let imageFile = PFFile(name: "image.png", data: imageData)
                post["imageFile"] = imageFile
                post.saveInBackground { (success, error) in
                    
                    activityIndicator.stopAnimating()
                    
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    
                    if (success) {
                        
                        self.displayAlert(title: "Image Posted", message: "Your image has been posted successfully!")
                        self.comment.text  = ""
                        self.imageToPost.image = nil
                        
                    } else {
                        self.displayAlert(title: "Image has not be posted", message: "Please try again later")
                    }
                }
            }
            
        }
        
    
    }
    @IBOutlet var comment: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
