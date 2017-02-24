//
//  ViewController.swift
//  FaceIt
//
//  Created by showxjn on 17/2/21.
//  Copyright © 2017年 Apress. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

	var expression = FacialExpression(eyes: .Closed, eyeBrows: .Normal, mouth: .Smile) {
		didSet {
			updateUI()
		}
	}
	
	@IBOutlet weak var faceView: FaceView! {
		didSet {
			faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changedScale(_:))))
			let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.IncreaseHappiness))
			happierSwipeGestureRecognizer.direction = .Up
			faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
			updateUI()
		}
	}
	
	func IncreaseHappiness() {
		expression.mouth = expression.mouth.happierMouth()
	}
	
	private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Smirk: -0.5, .Neutral: 0.0]
	private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]
	
	private func updateUI() {
		switch expression.eyes {
		case .Open:  faceView.eyesOpen = true
		case .Closed: faceView.eyesOpen = false
		case .Squinting: faceView.eyesOpen = false
		}
		faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
		faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
	}


}

