//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 大島秀平 on 2021/06/05.
//

import UIKit
import FirebaseUI

class PostTableViewCell: UITableViewCell{

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var verticalStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        let subviews = verticalStackView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    //PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        //画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        //キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        //日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:MM"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        //いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        //いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        //コメントと名前表示
        //UILabel作成
        print("DEBUG_PRINT: \(postData.commentText.count)")
        for i in 0 ..< postData.commentText.count{
            //名前とコメントを水平方向に並べるためにUIStackViewを作成する
            let horizontalStackView = UIStackView(frame: .zero)
            horizontalStackView.axis = .horizontal
            horizontalStackView.alignment = .center
            horizontalStackView.distribution = .fillEqually
            horizontalStackView.spacing = 20
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.addArrangedSubview(horizontalStackView)
            //名前表示
            let nameLabel = UILabel()
            nameLabel.text = postData.commentUserName[i]
            horizontalStackView.addArrangedSubview(nameLabel)
            //コメント表示
            let commentLabel = UILabel()
            commentLabel.text = postData.commentText[i]
            horizontalStackView.addArrangedSubview(commentLabel)
        }
    }
}
