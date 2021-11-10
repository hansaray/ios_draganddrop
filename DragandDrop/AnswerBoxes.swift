//
//  AnswerBoxes.swift
//  DragandDrop
//
//  Created by serhan özyılmaz on 2021. 11. 08..
//

import Foundation
import UIKit

class AnswerBoxes {
    
    static var answerBoxesArray = [UIView]()
    static let line = UIView()
    private struct LocalConstants {
        static var ANSWER_COLOR : UIColor = .green
        static var TEXT_SIZE = 50
        static var ANSWER_WIDTH = 35
    }
    
    static func isTouched(view: UIView) -> Bool {
        var check = false
        for i in 0..<answerBoxesArray.count {
            let dummyView = answerBoxesArray[i]
            view.bounds.size = CGSize(width: 1, height: 1)
            if view.frame.intersects(dummyView.frame) {
                //Get subviews of movableBox UIView
                let viewArray = view.subviews
                let movableBox : UILabel = viewArray[0] as! UILabel
                //Get subview of answerBox UIView
                let viewArray2 = dummyView.subviews
                let answerBox : UILabel = viewArray2[0] as! UILabel
                //Inserting given number to answerBox
                answerBox.text = movableBox.text
                answerBox.textColor = LocalConstants.ANSWER_COLOR
                check = true
                break
            }
        }
        return check
    }
        
    static func clearAnswerBoxes() {
        for i in 0..<answerBoxesArray.count {
            let dummyView = answerBoxesArray[i]
            let viewArray = dummyView.subviews
            let label : UILabel = viewArray[0] as! UILabel
            label.text = "0"
            label.textColor = .lightGray
        }
    }

    static func setUpBoxesDecimal(view: UIView) {
        if answerBoxesArray.count == 4 {
            return
        }
        answerBoxesArray.removeAll()
        view.addSubview(line)
        let padding : CGFloat = 200
        for i in 0..<4 {
            let answerBox = UIView()
            let numberAnswered = UILabel()
            answerBoxesArray.insert(answerBox, at: i)
            view.addSubview(answerBox)
            switch i {
            case 1:
                answerBox.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.centerXAnchor, paddingTop: padding, paddingBottom: 0, paddingRight: -0.5, paddingLeft: 0, width: CGFloat(LocalConstants.ANSWER_WIDTH), height: CGFloat(LocalConstants.ANSWER_WIDTH+35))
            case 2:
                answerBox.anchor(top: view.topAnchor, bottom: nil, leading: view.centerXAnchor, trailing: nil, paddingTop: padding, paddingBottom: 0, paddingRight: 0, paddingLeft: 0.5, width: CGFloat(LocalConstants.ANSWER_WIDTH), height: CGFloat(LocalConstants.ANSWER_WIDTH+35))
            case 3:
                answerBox.anchor(top: view.topAnchor, bottom: nil, leading: view.centerXAnchor, trailing: nil, paddingTop: padding, paddingBottom: 0, paddingRight: 0, paddingLeft: (CGFloat(LocalConstants.ANSWER_WIDTH)+1.5), width: CGFloat(LocalConstants.ANSWER_WIDTH), height: CGFloat(LocalConstants.ANSWER_WIDTH+35))
            default: //0
                answerBox.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.centerXAnchor, paddingTop: padding, paddingBottom: 0, paddingRight: -(CGFloat(LocalConstants.ANSWER_WIDTH)+1.5), paddingLeft: 0, width: CGFloat(LocalConstants.ANSWER_WIDTH), height: CGFloat(LocalConstants.ANSWER_WIDTH+35))
            }
            let color : UIColor = .gray
            answerBox.layer.borderColor = color.cgColor
            answerBox.layer.borderWidth = 1.0
            answerBox.layer.cornerRadius = 10
            answerBox.clipsToBounds = true
            answerBox.addSubview(numberAnswered)
            numberAnswered.anchor(top: answerBox.topAnchor, bottom: answerBox.bottomAnchor, leading: answerBox.leadingAnchor, trailing: answerBox.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingRight: 0, paddingLeft: 0, width: 0, height: 0)
            numberAnswered.textAlignment = .center
            numberAnswered.font = UIFont.systemFont(ofSize: CGFloat(LocalConstants.TEXT_SIZE-2))
            numberAnswered.text = "0"
            numberAnswered.textColor = .lightGray
        }
    }
}
