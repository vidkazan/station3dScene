//
//  PathGenerator.swift
//  3dSceneSwiftUI
//
//  Created by Dmitrii Grigorev on 17.09.23.
//

import Foundation
import UIKit
import Turf

class PathGenerator {
	static func generateFromPolygon(poly: [(Double,Double)]) -> CGMutablePath{
		let path = CGMutablePath()

		for coordinate in poly {
			let point = CGPoint(x: coordinate.0, y: coordinate.1)
			if path.isEmpty {
				path.move(to: point)
			} else {
				path.addLine(to: point)
			}
			path.closeSubpath()
		}
		print(path)
		return path
	}
}
