//
//  GraphView.swift
//  CalcGraph_I
//
//  Created by Chris William Sehnert on 8/23/17.
//  Copyright © 2017 InSehnDesigns. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {

    // public API
    
    // scale is at times a denominator and therefore should never be allowed to be zero....
    var scale: CGFloat = 1.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var axesColor: UIColor = UIColor.brown { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var pathColor: UIColor = UIColor.black { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var pathWidth: CGFloat = 2 { didSet { setNeedsDisplay() } }
    
    var axesOrigin: CGPoint = CGPoint(x: 170, y: 300) { didSet { setNeedsDisplay() } }
    
    var axes = AxesDrawer()
    
    var maxPoints: Int? { didSet { setNeedsDisplay() } }
    
    
    // graphSizeX and graphSizeY assume superview is ViewController.view
    var graphSizeX: CGFloat? {
        return self.superview?.bounds.maxX
    }
    var graphSizeY: CGFloat? {
        return self.superview?.bounds.maxY
    }
    var xCoordinate: CGFloat?
    var yPoint: CGFloat?
    
    var minYValue: CGFloat?
    var maxYValue: CGFloat?
    
    var pathStart: Bool = true
    
    var pathPoint: CGPoint?
    
    var equationPath: UIBezierPath? { didSet { setNeedsDisplay() } }
    
    func colorizeAxes () {
        axes.color = axesColor
    }
    
    func numberOfGraphPoints() {
        if graphSizeX != nil {
            maxPoints = Int(graphSizeX!)
            // print("\(maxPoints!) \n")
        }
    }
    
    func calculateYValueRange () {
        var scaleTranslation = contentScaleFactor * scale
        if scaleTranslation == 0.0 {
            scaleTranslation = contentScaleFactor * 1
        }
        if graphSizeY != nil {
            maxYValue = axesOrigin.y / scaleTranslation
            minYValue = maxYValue! - (graphSizeY! / scaleTranslation)
            // print("maxY value is \(maxYValue!)\nminY value is \(minYValue!)")
        }
    }
    
    func convertGraphPointsToXCoordinate (graphPoint: Int) {
        var scaleTranslation = contentScaleFactor * scale
        if scaleTranslation == 0.0 {
            scaleTranslation = contentScaleFactor * 1
        }
        
        xCoordinate = (CGFloat(graphPoint) - axesOrigin.x) / scaleTranslation
        // print("first x-value is \(xCoordinate!)\n")
    }
    
    func convertYCoordinateToGraphPoint (yCoordinate: CGFloat) {
        var scaleTranslation = contentScaleFactor * scale
        if scaleTranslation == 0.0 {
            scaleTranslation = contentScaleFactor * 1
        }
        
        yPoint = (axesOrigin.y - (yCoordinate * scaleTranslation))
        // print("PointY is currently \(yPoint!)")
    }
    
    func createPointFromCoordinate (graphPointX: Int, yValue: CGFloat) {
        convertYCoordinateToGraphPoint(yCoordinate: yValue)
        if yPoint != nil {
            pathPoint = CGPoint(x: CGFloat(graphPointX), y: yPoint!)
        }
        else {
            pathPoint = nil
            pathStart = true
        }
    }
    
  /*
    func moveOrigin (byReactingTo tapGesture: UITapGestureRecognizer) {
        if tapGesture.state == .ended {
            axesOrigin = tapGesture.location(in: self)
            // numberOfGraphPoints()
            // convertGraphPointsToXCoordinate(graphPoint: 0)
            // calculateYValueRange()
            // convertYCoordinateToGraphPoint(yCoordinate: -100)
        }
    }
    
    func panOrigin (byReactingTo panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            panGesture.setTranslation(axesOrigin, in: self)
        case .changed, .ended:
            axesOrigin = panGesture.translation(in: self)
        default:
            break
        }
    }
    
    func changeScale (byReactingTo pinchGesture: UIPinchGestureRecognizer) {
        switch pinchGesture.state  {
        case .changed, .ended:
            scale *= pinchGesture.scale
            pinchGesture.scale = 1
        default:
            break
        }
    }
 */
    override func draw(_ rect: CGRect) {
        
        axesColor.set()
        pathColor.set()
        axes.drawAxes(in: bounds, origin: axesOrigin, pointsPerUnit: contentScaleFactor * scale)
        equationPath?.stroke()
        
    }
    
}








