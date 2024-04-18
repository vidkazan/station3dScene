//
//  ViewModel.swift
//  3dSceneSwiftUI
//
//  Created by Dmitrii Grigorev on 17.09.23.
//

import Foundation
import UIKit
import Turf
import CoreLocation

class ViewModel {
	var polys : [Polygon] = []
	var polysNormalised : [Polygon] = []
	init() {
		decodeTurf()
	}
	
	func decodeTurf(){
		if let asset = NSDataAsset(name: "test") {
			let data = asset.data
			do {
				let geojson = try JSONDecoder().decode(GeoJSONObject.self, from: data)
				guard case .featureCollection(let collection) = geojson else {
					return
				}
				
				collection.features.map {
					if case .polygon(let poly) = $0.geometry {
						polys.append(poly)
					}
				}
			} catch {
				
			}
		} else {
			print("file not found")
		}
	}
	
	func transform(poly : Polygon) -> [(Double,Double)] {
		var mininalX : Double = .greatestFiniteMagnitude
		var mininalY : Double = .greatestFiniteMagnitude
		poly.outerRing.coordinates.map {
			mininalX = ($0.latitude < mininalX) ? $0.latitude : mininalX
			mininalY = ($0.longitude < mininalY) ? $0.longitude : mininalY
		}
		return poly.outerRing.coordinates.map {
			(Double($0.latitude - mininalX)*1110,Double($0.longitude - mininalY)*1110)
		}
	}
}
