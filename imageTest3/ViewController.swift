//
//  ViewController.swift
//  imageTest3
//
//  Created by 김기훈 on 2020/09/19.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    var movies = [
        Movie(name: "킹덤", image: "kiki", year: 2019),
        Movie(name: "쏘우", image: "", year: 2000)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = "i'm kiki"
        image1.image = UIImage(named: "kiki")
    }
}

