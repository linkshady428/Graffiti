//
//  PhotoViewController.swift
//  Graffiti
//
//  Created by Teng-Sheng Ho on 2019/9/9.
//  Copyright © 2019 Mh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit
import CoreLocation
import Firebase

class PhotoViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var desView: UITextView!
    @IBOutlet weak var tagView: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    var pickImage = UIImagePickerController()
    var ref: DatabaseReference! = Database.database().reference()
    let locationManager = CLLocationManager()
    var imageID:String!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        super.viewDidLoad()
    }

    @IBAction func cancelAction(_ sender: Any) {
        finishButton.isHidden = false
        chooseButton.isHidden = false
        uploadButton.isHidden = true
        cancelButton.isHidden = true
        desView.isEditable = true
        tagView.isEnabled = true
        desView.backgroundColor = UIColor.white
        tagView.backgroundColor = UIColor.white
        locationText.backgroundColor = UIColor.white
    }
    
    @IBAction func finishAction(_ sender: Any) {
        if(imageView.image == nil){
            let alertController = UIAlertController(title: "Error", message: "Select an image", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            finishButton.isHidden = true
            chooseButton.isHidden = true
            uploadButton.isHidden = false
            cancelButton.isHidden = false
            desView.isEditable = false
            tagView.isEnabled = false
            desView.backgroundColor = UIColor.clear
            tagView.backgroundColor = UIColor.clear
            locationText.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        imageID = (self.ref?.child("Image").childByAutoId().key)
        uploadMedia() { url in
            guard url != nil else { return }
            self.ref?.child("images").childByAutoId().setValue([
                "description"     : self.desView.text!,
                "location"        : self.locationText.text!,
                "tag"             : self.tagView.text!,
                "uuid"             : Auth.auth().currentUser?.uid
                ])
        }
        
        
    }
    
    
    @IBAction func chooseAction(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Location manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationText.text = "\(locValue.latitude) \(locValue.longitude)"
    }
    
    
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            pickImage.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            pickImage.allowsEditing = true
            pickImage.delegate = self
            self.present(pickImage, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from gallery
    func openGallary(){
        pickImage.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        pickImage.allowsEditing = true
        pickImage.delegate = self
        self.present(pickImage, animated: true, completion: nil)
    }
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        
        let path = imageID + ".jpg"
        let storageRef = Storage.storage().reference().child("images").child(path)
        let newMetadata = StorageMetadata()
        newMetadata.contentType = "image/jpeg";
        
        if let uploadData = imageView.image?.jpegData(compressionQuality: 0.22) {
            storageRef.putData(uploadData,metadata: newMetadata) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        print(url?.absoluteString as Any)
                        completion(url?.absoluteString)
                        
                        let alert = UIAlertController(title: "Successful!", message: "Upload Succefully!", preferredStyle: UIAlertController.Style.alert )
                    
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            self.navigationController?.popViewController(animated: true)
                       }))
                       self.present(alert, animated:true, completion: nil)
                            
                    })
                    
                    
                }
            }
        }
    }
    
    /*@IBAction func uploadAction(_ sender: Any) {
        
        imageID = (self.ref?.child("Image").childByAutoId().key)
        uploadMedia() { url in
            guard url != nil else { return }
            self.ref?.child("images").childByAutoId().setValue([
                "uid"              : Auth.auth().currentUser?.uid,
                "description"     : "lllooo",
                "location"       : self.locationText.text!,
                ])
        
        
        }
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UIImagePickerControllerDelegate

extension PhotoViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imageView.image = editedImage
        }
        
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
