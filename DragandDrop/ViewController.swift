//
//  ViewController.swift
//  DragandDrop
//
//  Created by serhan özyılmaz on 2021. 11. 05..
//

import UIKit

class ViewController: UIViewController {
    
    private struct LocalConstants {
        static var blockDimension: CGFloat = 50
    }
    private var beginningPosition: CGPoint = .zero
    private var initialMovableViewPosition: CGPoint = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        addMovableViews(count: 10)
        AnswerBoxes.setUpBoxesDecimal(view: view)
    }
    
    public func addMovableViews(count: Int) {
        let totalWidth = view.frame.width
        let blockSize = LocalConstants.blockDimension * 5
        let totalSpace = totalWidth - blockSize
        let oneSpace = totalSpace / 6
        var xOffset = oneSpace
        for i in 0..<count {
            let movableView = UIView()
            view.addSubview(movableView)
            if i > 4 {
                movableView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -85, paddingRight: 0, paddingLeft: xOffset, width: LocalConstants.blockDimension, height: LocalConstants.blockDimension)
            } else {
                movableView.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -150, paddingRight: 0, paddingLeft: xOffset, width: LocalConstants.blockDimension, height: LocalConstants.blockDimension)
            }
            let textInside = UILabel()
            textInside.textAlignment = .center
            textInside.font = UIFont.systemFont(ofSize: 30.0)
            textInside.text = String(i)
            textInside.textColor = .blue
            movableView.addSubview(textInside)
            textInside.anchor(top: movableView.topAnchor, bottom: movableView.bottomAnchor, leading: movableView.leadingAnchor, trailing: movableView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingRight: 0, paddingLeft: 0, width: 0, height: 0)
            movableView.backgroundColor = .lightGray
            movableView.layer.cornerRadius = 25
            movableView.clipsToBounds = false
            movableView.layer.shadowRadius = 1
            movableView.layer.shadowOffset = CGSize(width: 0, height: 3)
            movableView.layer.shadowOpacity = 0.4
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(touched(_:)))
            movableView.addGestureRecognizer(gestureRecognizer)
            if i == 4 {
                xOffset = oneSpace
            } else {
                xOffset += LocalConstants.blockDimension + oneSpace
            }
        }
    }
    
    //Drag and drog function
    @objc fileprivate func touched(_ gestureRecognizer: UIGestureRecognizer) {
        if let touchedView = gestureRecognizer.view {
            if gestureRecognizer.state == .began {
                beginningPosition = gestureRecognizer.location(in: touchedView)
                initialMovableViewPosition = touchedView.frame.origin
            } else if gestureRecognizer.state == .ended {
                if AnswerBoxes.isTouched(view: touchedView) {
                }
                //movableBox goes back to beginning position
                touchedView.frame.origin = initialMovableViewPosition
                touchedView.backgroundColor = .lightGray
                touchedView.layer.shadowOpacity = 0.4
                gestureRecognizer.state = .ended
            } else if gestureRecognizer.state == .changed {
                let locationInView = gestureRecognizer.location(in: touchedView)
                touchedView.backgroundColor = .clear
                touchedView.layer.shadowOpacity = 0
                touchedView.frame.origin = CGPoint(x: touchedView.frame.origin.x + locationInView.x - beginningPosition.x, y: touchedView.frame.origin.y + locationInView.y - 100 + beginningPosition.y)
            }
        }
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        AnswerBoxes.clearAnswerBoxes()
    }
    
}

