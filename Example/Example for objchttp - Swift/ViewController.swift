//
//  ViewController.swift
//  Example for objchttp - Swift
//
//  Created by Alley Pereira on 29/07/21.
//  Copyright © 2021 32482081. All rights reserved.
//

import UIKit
import objchttp

class ViewController: UIViewController {

    @IBOutlet weak var getTextView: UITextView!

    var request: httpRequest?

    // MARK: - GET REQUEST
    @IBAction func getButton(_ sender: UIButton) {
        request?.fetchData("/posts/1", completion: { result in
            DispatchQueue.main.async {
                self.getTextView.text = "CALLBACK GET 🚀\n\(result!)"
            }
            print("CALLBACK GET\n", result!)
        })

    }


    // MARK: - POST REQUEST
    @IBAction func postButton(_ sender: UIButton) {
        let dict = NSMutableDictionary(object: "pikachu", forKey: "name" as NSCopying)
        dict.setValue("ios dev", forKey: "job")
        request?.postData(dict, "/posts", completion: { result in
            DispatchQueue.main.async {
                self.getTextView.text = "CALLBACK POST 🚀\n\(result!)"
            }
        })
    }

    // MARK: - PUT REQUEST
    @IBAction func putButton(_ sender: UIButton) {
        let dict = NSMutableDictionary(object: "Charizard", forKey: "name" as NSCopying)
        dict.setValue("android dev", forKey: "job")
        request?.putData(dict, "/users/2", completion: { result in
            DispatchQueue.main.async {
                self.getTextView.text = "CALLBACK PUT 🚀\n\(result!)"
            }
        })
    }

    // MARK: - DELETE REQUEST
    @IBAction func deleteButton(_ sender: UIButton) {
        request?.deleteData("/users/2", completion: { result in
            DispatchQueue.main.async {
                self.getTextView.text = "CALLBACK DELETE 🚀\n\(result!)"
            }
            print("CALLBACK DELETE\n", result!)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        request = httpRequest()
        request?.host = "://jsonplaceholder.typicode.com"
        request?.schema = "https"

    }


}

