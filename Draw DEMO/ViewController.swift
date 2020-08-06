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
        context.setStrokeColor(strokeColour)
        
        // set width
        // context.setLineWidth(10)
        context.setLineWidth(CGFloat(lineWidth))

        
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
    var lineWidth: Float = 6.0
    var strokeColour = UIColor.black.cgColor
    
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

    @IBAction func coloursIsChanged(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            // black selected
            canvas.strokeColour = UIColor.black.cgColor
        case 1:
            // red selected
            canvas.strokeColour = UIColor.red.cgColor
        case 2:
            // green selected
            canvas.strokeColour = UIColor.green.cgColor
        case 3:
            // yellow selected
            canvas.strokeColour = UIColor.yellow.cgColor
        default:
            // default colour [black] shouldn't fire
            canvas.strokeColour = UIColor.black.cgColor
        }
    }

    @IBAction func sliderMoved(_ sender: UISlider) {
        // line width changes to slider value
        canvas.lineWidth = sender.value
    }
    
}

