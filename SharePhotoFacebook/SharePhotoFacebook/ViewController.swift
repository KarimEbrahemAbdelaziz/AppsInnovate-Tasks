//
//  ViewController.swift
//  SharePhotoFacebook
//
//  Created by KARIM on 6/24/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageToShare: UIImageView!
    let pickImage = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set this VC as delegate for UIImagePickerController
        pickImage.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseImageFromGallary(_ sender: UIButton) {
        // allowsEditing is false by default no need for set it
        // sourceType is photoLibrary is default source type
        
        // present ImagePickerVC to pick an image for post
        present(pickImage, animated: true, completion: nil)
    }
    
    @IBAction func shareImageToFacebook(_ sender: UIButton) {
        // i used SLComposeVC that provided by Apple thta allow me to create post for FB, Twitter
        // user must be login to FB or Twitter on the devicee that use the app
        // i found it easier to handle the task later i will give a look and use to FB SDK
        let post = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        
        // add image to the post
        post?.add(imageToShare.image)
        
        // present SLComposeVC to make user confirm if he would to post it
        self.present(post!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // get the image that had been picked from ImagePickerController
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // set the image to my imageView so user can see it before post it to FB
        imageToShare.contentMode = .scaleToFill
        imageToShare.image = pickedImage
        
        // dismiss the ImagePickerVC after finish picking photo
        dismiss(animated: true, completion: nil)
    }
}

