//
//  ActorsViewController.swift
//  imageTest3
//
//  Created by 김기훈 on 2020/09/20.
//

import UIKit
import SwiftLinkPreview
import RealmSwift

class ActorsViewController: UIViewController {
    
    @IBOutlet weak var imageController: UIImageView!
    
    @IBOutlet weak var urlDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let realm = try! Realm()
        print("\(realm.configuration.fileURL?.absoluteString)")
        let slp = SwiftLinkPreview(session: URLSession.shared, workQueue: SwiftLinkPreview.defaultWorkQueue, responseQueue: DispatchQueue.main, cache: DisabledCache.instance)
        slp.preview("https://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=105&oid=421&aid=0004896646",
                    onSuccess: {
                        result in
                        print("\(result.image)")
                        print("\(result.icon)")
                        print("\(result.title)")
                        
                        if let imageUrl = result.image{
                            if let imageUrl: URL = URL(string: imageUrl){
                                self.imageController.load(url: imageUrl)
                            }
                        }
                        
                        self.urlDescription.text = result.title
                    }, onError: {error in print("error")})
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


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
