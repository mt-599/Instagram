//
//  PostDetailTableViewCell.swift
//  Instagram
//
//  Created by 大島秀平 on 2021/06/15.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentText: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //PostDataの内容をセルに表示
    func setCommentData(_ text: String, name: String) {
        userName.text = name
        commentText.text = text
    }
    
}
