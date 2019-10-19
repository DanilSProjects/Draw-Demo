//
//  ViewController.swift
//  Draw DEMO
//
//  Created by Daniel on 19/10/19.
//  Copyright © 2019 Placeholder Interactive. All rights reserved.
//

import UIKit

class Canvas: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return }
        
        //set colour
        //context.setStrokeColor(UIColor.red.cgColor)
        
        // set width
        // context.setLineWidth(10)
        
        lines.forEach {(line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        context.strokePath()
    }
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else {
            return }
        guard var lastLine = lines.popLast() else {
            return }
        
        lastLine.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var cView: UIView!
    
    let canvas = Canvas()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(cView)
        view.addSubview(canvas)
        canvas.backgroundColor = .white
        canvas.frame = cView.frame
    }


}

