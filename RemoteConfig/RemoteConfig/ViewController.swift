//
//  ViewController.swift
//  RemoteConfig
//
//  Created by Taha on 20/04/2022.
//

import UIKit
import FirebaseRemoteConfig

class ViewController: UIViewController {
    
    @IBOutlet weak var dynamicLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDynamicLabel()
        
    }

    func loadDynamicLabel() {
        RemoteDataManager.sharedInstance.fetchCloudValues { [weak self] fetchedText, error in
            if error != nil {
                print(error?.localizedDescription)
                DispatchQueue.main.async {
                    self?.dynamicLabel.text = "Undifined"
                }
            } else {
                DispatchQueue.main.async {
                    self?.dynamicLabel.text = fetchedText
                }
            }
        }
    }

}

