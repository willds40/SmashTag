//
//  PictureViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/11/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, UIScrollViewDelegate{
    var imageURL:NSURL?{
        didSet{
            image = nil
            fetchImage()
        }
    }
    
    private var imageView = UIImageView()
    
    
    
    private func fetchImage(){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        if let url = self?.imageURL{
            if let imageData = NSData(contentsOf:url as URL){
                DispatchQueue.main.sync{
                self?.image = UIImage(data: imageData as Data)
            }
            }
        }
    }
}
    
    private var image: UIImage?{
        get{
        return imageView.image
        }
        set{
        imageView.image = newValue
        imageView.sizeToFit()
        scrollView?.contentSize = imageView.frame.size
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
        scrollView.contentSize = imageView.frame.size
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
       

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
