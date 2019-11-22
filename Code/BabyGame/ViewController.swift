//
//  ViewController.swift
//  BabyGame
//
//  Created by Marvin Mouroum on 19.11.19.
//  Copyright © 2019 eurecom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circle: UIImageView!
    @IBOutlet weak var square: UIImageView!
    @IBOutlet weak var rectangle: UIImageView!
    @IBOutlet weak var oval: UIImageView!
    @IBOutlet weak var triangle: UIImageView!
    
    @IBOutlet weak var button: UIImageView!
    @IBOutlet weak var slot: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
        //adding the pan gesture recognizer for dragging
        addGesture(view: circle)
        addGesture(view: square)
        addGesture(view: rectangle)
        addGesture(view: oval)
        addGesture(view: triangle)
        addGesture(view: button)
        
        //adding a tag for identification
        circle.tag = 0
        square.tag = 1
        rectangle.tag = 2
        oval.tag = 3
        triangle.tag = 4
        button.tag = 5
        
        //put the views at random places
        shuffle()
    }
    
    func shuffle(){
        triangle.center = CGPoint(x: width*CGFloat.random(in: 0..<1), y: height*CGFloat.random(in: 0..<0.5))
        circle.center = CGPoint(x: width*CGFloat.random(in: 0..<1), y: height*CGFloat.random(in: 0..<0.5))
        square.center = CGPoint(x: width*CGFloat.random(in: 0..<1), y: height*CGFloat.random(in: 0..<0.5))
        oval.center = CGPoint(x: width*CGFloat.random(in: 0..<1), y: height*CGFloat.random(in: 0..<0.5))
    }
    
    

    //the starting position of a view at first touch
    var start:CGPoint = CGPoint()
    
    //a generator for haptic touch feedback
    let generator = UINotificationFeedbackGenerator()
    
    @objc func dragging(_ sender:UIPanGestureRecognizer){
        
        //setting a shadow when view is dragged and update the starting value
        if sender.state == .began {
            start = sender.view?.center ?? CGPoint()
            sender.view?.layer.shadowRadius = 15
            sender.view?.layer.shadowOpacity = 0.75
            sender.view?.layer.shadowColor = UIColor.black.cgColor
            sender.view?.layer.shadowOffset = CGSize()
            
            generator.prepare()
        }
        
        //update the position
        sender.view?.center = start.add(for:sender.translation(in: self.view))
        
        
        //evaluate the result
        if sender.state == .ended {
            
            //remove shadow
            sender.view?.layer.shadowRadius = 0
            
            //evaluate the point if it is in the right location of the view
            var point = CGPoint()
            switch (sender.view?.tag) {
            case 3:
                point = CGPoint(x:0.2608695652173913*width,y:0.7377232142857143*height)
                break
            case 0:
                point = CGPoint(x:0.782608695652174*width,y:0.5799851076943534*height)
                break
            case 1:
            point =
            CGPoint(x:0.7560386473429952*width,y:0.7857142857142857*height)
            break
            case 2:
                point =
                CGPoint(x:0.5048309178743962*width,y:0.8139880895614624*height)
                break
            case 4:
                point = CGPoint(x:0.5064411992612092*width,y:0.65625*height)
                break
            case 5:
                point = CGPoint(x:0.41183574879227053*width,y:0.12220982142857142*height)
                break
            default:
                print("doesnt exist")
            }
            
            //check if the view is in range of the wanted position
            //marging can adjust the precisness
            if !sender.view!.center.inRange(point: point, margin: 0.1) && start != point{
                if (sender.view!.center.y > height/2) {
                    
                    sender.view?.center = start
                    generator.notificationOccurred(.error)
                }
            }
                // add the view to its location and give haptic feedback
            else if start != point && (sender.view!.center.y > height/2 || sender.view!.tag == 5) {
                sender.view?.center = point
                generator.notificationOccurred(.success)
            }
        }
    }
    
    var width:CGFloat {
        return UIScreen.main.bounds.width
    }
    var height:CGFloat {
        return UIScreen.main.bounds.height
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let point = touches.first?.location(in: self.view)
        print("CGPoint(x:\((point?.x ?? 1)/width)*width,y:\((point?.y ?? 1)/height)*height)")
    }
    
    func addGesture(view:UIView){
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragging(_:))))
    }
    
    //adding the shuffle function to reset
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if(event?.subtype == UIEvent.EventSubtype.motionShake) {
            self.shuffle()
        }
    }


}

extension CGPoint {
    
    mutating func add(toMe:CGPoint){
        self.x += toMe.x
        self.y += toMe.y
    }
    
    func add(for point:CGPoint)->CGPoint{
        return CGPoint(x: self.x + point.x,y: self.y + point.y)
    }
    
    func inRange(point: CGPoint, margin:CGFloat = 0.1)->Bool{
        
        if point.x > self.x*(1-margin) && point.x < self.x*(1+margin) &&
            point.y > self.y*(1-margin) && point.y < self.y*(1+margin){
            
            return true
        }
        
        return false
    }
    
    
}



