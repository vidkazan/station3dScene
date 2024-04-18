//
//  Model.swift
//  3dSceneSwiftUI
//
//  Created by Dmitrii Grigorev on 17.09.23.
//

import Foundation


struct GeoJsonDTO : Codable, Equatable,Hashable {
	let type : String?
	let features : [Feature?]
}

extension GeoJsonDTO {
	struct Feature : Codable, Equatable,Hashable {
		let type : String?
		let geometry : Geometry?
	}
	
	struct CGFeature : Equatable {
		let type : String?
		let geometry : CGGeometry?
	}
	
	struct Geometry : Codable,Equatable,Hashable {
		let type : String?
		let coordinates : [[[Double?]]]
	}
	struct CGGeometry : Equatable {
		let type : String?
		let coordinatesIncluding : [CGPoint]
		let coordinatesExcluding : [[CGPoint]]
	}
}
