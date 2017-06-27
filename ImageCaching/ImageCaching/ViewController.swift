//
//  TableViewController.swift
//  ImageCaching
//
//  Created by KARIM on 6/25/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // create an instance of Images class, you can add image links there :)
    var imagesToLoadFromInternet: Images? = nil
    
    // get outlet to my TableView to work with
    @IBOutlet weak var imagesTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesToLoadFromInternet = Images()
        
        // set this class as tableView delegate and data source
        imagesTabelView.delegate = self
        imagesTabelView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imagesToLoadFromInternet!.imagesUrls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)

        let imageView = cell.viewWithTag(1) as! UIImageView
        let imageURL = URL(string: imagesToLoadFromInternet!.imagesUrls[indexPath.row])
        
        // i used SDWebImage lib to handle getting photos from links and chached them
        // this library provides an async image downloader with cache support
        // for info about this lib: https://github.com/rs/SDWebImage
        imageView.sd_setImage(with: imageURL)
        
        return cell
    }
}
