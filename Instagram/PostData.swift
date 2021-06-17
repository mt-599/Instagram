//
//  PostData.swift
//  Instagram
//
//  Created by 大島秀平 on 2021/06/05.
//

import UIKit
import Firebase

struct Comment{
    var text: String
    var name: String
    
    func getText() -> String{
        return text
    }
    func getName() -> String{
        return name
    }
}

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var commentText: [String] = []
    var commentUserName: [String] = []

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        let postDic = document.data()
        self.name = postDic["name"] as? String
        self.caption = postDic["caption"] as? String
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let text = postDic["commentText"] as? [String] {
            self.commentText = text
        }
        if let name = postDic["commentUserName"] as? [String] {
            self.commentUserName = name
        }
        if let myid = Auth.auth().currentUser?.uid {
            //likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                //myidがあれば、いいねを押したと認識する
                self.isLiked = true
            }
        }
    }

}
