//
//  ShareViewController.swift
//  myShareExtention
//
//  Created by 김기훈 on 2020/09/21.
//

import UIKit
import Social
import MobileCoreServices
import RealmSwift

class Bookmark : Object {
    @objc dynamic var url: String = ""
    @objc dynamic var desc: String = ""
}


class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        
        // contentText : 유저가 공유하기 창을 눌러 넘어온 문자열 값(상수)
        if let currentMessage = contentText{
            let currentMessageLength = currentMessage.count
            // charactersRemaining : 문자열 길이 제한 값(상수)
            charactersRemaining = (100 - currentMessageLength) as NSNumber
            
            print("currentMessage : \(currentMessage) // 길이 : \(currentMessageLength) // 제한 : \(charactersRemaining)")
            if Int(charactersRemaining) < 0 {
                print("100자가 넘었을때는 공유할 수 없다!")
                return false
            }
        }
        return true
    }

    override func didSelectPost() {
        print("didselectPost")
        if let item = extensionContext?.inputItems.first as? NSExtensionItem {
            accessWebpageProperties(extensionItem: item)
        }
        
//        let realm = try! Realm()
        
        guard var fileURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.imageTest3") else {
                print("Container URL is nil")
                return
        }

        fileURL.appendPathComponent("shared.realm")

        Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: fileURL)
        
        let realm = try! Realm(fileURL: fileURL)
        print("\(realm.configuration.fileURL?.absoluteString)")
        
        let bookmark = Bookmark()
        bookmark.desc = "hello"
        bookmark.url = "apple.com"
        do{
            try realm.write{ // realm.write{}는 git에서 commit을 해주는 것과 비슷하다.
                realm.add(bookmark) // 데이터베이스에 park 모델을 더한다.
            }
        } catch {
            print("Error Add \(error)")
        }
        print("add data done")
    }

    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    override func configurationItems() -> [Any]! {
        let item = SLComposeSheetConfigurationItem()
        
        item?.title = "여기는 제목입니다"
        // item?.tapHandler : 유저가 터치했을 때 호출되는 핸들러
        return [item]
    }
    
    private func accessWebpageProperties(extensionItem: NSExtensionItem) {

        
        // url 가져오기
        let propertyList = kUTTypePropertyList as String

        for attachment in extensionItem.attachments! where attachment.hasItemConformingToTypeIdentifier(propertyList) {
            attachment.loadItem(
                forTypeIdentifier: propertyList,
                options: nil,
                completionHandler: { (item, error) -> Void in

                    guard let dictionary = item as? NSDictionary,
                        let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                        let url = results["URL"] as? String else {
                            return
                        }

                    print("title: \(url)")
                }
            )
        }
    }
}
