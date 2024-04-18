//
//  SceneKitView.swift
//  3dSceneSwiftUI
//
//  Created by Dmitrii Grigorev on 17.09.23.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
	let vm = ViewModel()
	
	func makeUIView(context: Context) -> SCNView {
		let sceneView = SCNView()
		let scene = SCNScene()
		
		let blockSize: CGFloat = 1.0
		let spacing: CGFloat = 0.005

		// Create a block type enum (representing different block types)
		enum BlockType: Int {
			case air = 0
			case dirt = 1
			case grass = 2
			case stair = 3
		}

		// Define a grid of block types to represent your shape
		let shapeGrid0: [[BlockType]] = [
			[.air,.air,.air,.air,.air,.air,.air,.air],
			[.air,.air,.air,.air,.air,.air,.air,.air],
			[.air,.air,.air,.air,.air,.air,.air,.air],
			[.air,.air,.air,.air,.air,.air,.air,.air],
			[.air,.air,.air,.air,.air,.air,.air,.air],
			[.air,.air,.air,.air,.air,.air,.air,.air],
			[.air,.stair,.air,.air,.air,.air,.stair,.air],
			[.grass,.grass,.grass,.grass,.grass,.grass,.grass,.grass],
			[.grass,.grass,.grass,.grass,.grass,.grass,.grass,.grass]
			
		]
		let shapeGrid1: [[BlockType]] = [
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.air,.dirt,.air,.air,.dirt,.air,.dirt],
			[.dirt,.air,.dirt,.air,.air,.dirt,.air,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt],
			[.dirt,.dirt,.dirt,.air,.air,.dirt,.dirt,.dirt]
		]

		// Create blocks for each grid element
		for (rowIndex, row) in shapeGrid0.enumerated() {
			for (colIndex, blockType) in row.enumerated() {
				var blockNode : SCNNode!
				switch blockType {
				case .stair:
					blockNode = SCNNode(geometry: SCNBox(width: blockSize, height: blockSize/10, length: blockSize*2.3, chamferRadius: 0.25))
					blockNode.position = SCNVector3(
						Float(colIndex) * Float(blockSize + spacing),
						0.5,
						Float(rowIndex) * Float(blockSize + spacing) - 0.5
					)
					blockNode.eulerAngles = .init(x: 0.5, y: 0, z: 0)
				default :
					blockNode = SCNNode(geometry: SCNBox(width: blockSize, height: blockSize/10, length: blockSize, chamferRadius: 0.25))
					blockNode.position = SCNVector3(
						Float(colIndex) * Float(blockSize + spacing),
						0,
						Float(rowIndex) * Float(blockSize + spacing)
					)
				}
				
				
				// Apply materials and textures based on block type
				switch blockType {
				case .air:
					// You can set a transparent material for air blocks
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
				case .dirt:
					// Apply a dirt texture to dirt blocks
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemGray
				case .grass:
					// Apply a grass texture to grass blocks
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor(hue: 0.12, saturation: 0.2, brightness: 0.8, alpha: 1)
				case .stair:
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
				}
				
				// Add the block node to the scene
				scene.rootNode.addChildNode(blockNode)
			}
		}

		
		for (rowIndex, row) in shapeGrid1.enumerated() {
			for (colIndex, blockType) in row.enumerated() {
				var blockNode : SCNNode!
				switch blockType {
				case .stair:
					blockNode = SCNNode(geometry: SCNBox(width: blockSize, height: blockSize/10, length: blockSize*1.3, chamferRadius: 0.25))
					blockNode.position = SCNVector3(
						Float(colIndex) * Float(blockSize + spacing),
						1.5,
						Float(rowIndex) * Float(blockSize + spacing)
					)
					blockNode.eulerAngles = .init(x: 0.8, y: 0, z: 0)
				default :
					blockNode = SCNNode(geometry: SCNBox(width: blockSize, height: blockSize/10, length: blockSize, chamferRadius: 0.25))
					blockNode.position = SCNVector3(
						Float(colIndex) * Float(blockSize + spacing),
						1,
						Float(rowIndex) * Float(blockSize + spacing)
					)
				}
				
				
				// Apply materials and textures based on block type
				switch blockType {
				case .air:
					// You can set a transparent material for air blocks
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
				case .dirt:
					// Apply a dirt texture to dirt blocks
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemGray.withAlphaComponent(0.7)
				case .grass:
					// Apply a grass texture to grass blocks
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor(hue: 0.12, saturation: 0.2, brightness: 0.8, alpha: 1)
				case .stair:
					blockNode.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
				}
				
				// Add the block node to the scene
				scene.rootNode.addChildNode(blockNode)
			}
		}
		
		
		
		
		
		// create and add a camera to the scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		scene.rootNode.addChildNode(cameraNode)
		
		// place the camera
		cameraNode.position = SCNVector3(x: 3, y: 0, z: 35)
		
		// create and add a light to the scene
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light!.type = .omni
		lightNode.position = SCNVector3(x: 0, y: 0, z: 20)
		scene.rootNode.addChildNode(lightNode)
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = .ambient
		ambientLightNode.light!.color = UIColor.darkGray
		scene.rootNode.addChildNode(ambientLightNode)
		
		// set the scene to the view
		sceneView.scene = scene
		
		// allows the user to manipulate the camera
		sceneView.allowsCameraControl = true
		sceneView.debugOptions = SCNDebugOptions(rawValue: 1024)
		
		// configure the view
		sceneView.backgroundColor = UIColor.black
		return sceneView
	}
	
	func updateUIView(_ uiView: SCNView, context: Context) {
		// Update your 3D scene if needed
	}
}
