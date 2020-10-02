//
//  ViewController.swift
//  imageTest3
//
//  Created by 김기훈 on 2020/09/19.
//

import UIKit
import RealmSwift

class Bookmark : Object {
    @objc dynamic var url: String = ""
    @objc dynamic var desc: String = ""
}

class ViewController: UIViewController {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    var movies = [
        Movie(name: "킹덤", image: "kiki", year: 2019),
        Movie(name: "쏘우", image: "", year: 2000)
    ]
    
    
    override func viewWillAppear(_ animated: Bool){
        label1.text = "i'm kiki"
        image1.image = UIImage(named: "kiki")
        print("kiki")
        
        guard var fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.imageTest3") else {
                print("Container URL is nil")
                return
        }

        fileURL.appendPathComponent("shared.realm")

        Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: fileURL)
        
        let realm = try! Realm(fileURL: fileURL)
        print("\(realm.configuration.fileURL?.absoluteString)")

//        let bookmark = realm.objects(Bookmark.self).first
//        print("bookmark desc: \(bookmark?.desc)")
//        print("bookmark url: \(bookmark?.url)")
        let bookmarks = realm.objects(Bookmark.self)
        
        bookmarks.forEach { (bookmark) in
            print("bookmark desc: \(bookmark.desc)")
            print("bookmark url: \(bookmark.url)")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

}
