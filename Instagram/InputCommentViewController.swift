//
//  InputCommentViewController.swift
//  Instagram
//
//  Created by 大島秀平 on 2021/06/09.
//

import UIKit
import Firebase

class InputCommentViewController: UIViewController {
    
    @IBOutlet weak var inputComment: UITextField!
    
    var docID: String = ""
    var textArray: [String] = []
    var nameArray: [String] = []
    
    @IBAction func cancelButton(_ sender: Any) {
        //コメント入力画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func replayButton(_ sender: Any) {
        print("DEBUG_PRINT: Press replayButton")
        let name = Auth.auth().currentUser?.displayName
        let text = inputComment.text
        print("DEBUG_PRINT: [inputCommentView]text: \(text!)")
        //コメントデータをFirebaseに保存
        self.textArray.append(text!)
        self.nameArray.append(name!)
        let postRef = Firestore.firestore().collection(Const.PostPath).document(self.docID)
        postRef.updateData(["commentText": self.textArray]){_ in
            postRef.updateData(["commentUserName": self.nameArray]) {_ in
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
