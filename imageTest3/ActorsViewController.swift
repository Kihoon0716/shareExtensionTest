//
//  ActorsViewController.swift
//  imageTest3
//
//  Created by 김기훈 on 2020/09/20.
//

import UIKit

class ActorsViewController: UIViewController {

    @IBOutlet weak var actorsBtn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        actorsBtn.text = "hello"
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
