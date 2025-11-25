
//
//  ContentView.swift
//  Augmented Reality App
//
//  Created by Anantha C on 2023-12-24.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        // Load the USDZ model
        if let modelEntity = try? Entity.load(named: "rowing_machine") { // Ensure this matches your asset name
            
            // ✅ Scale down the model (10% of original size)
            modelEntity.scale = SIMD3<Float>(0.1, 0.1, 0.1)
            
            // ✅ Adjust position so it sits on the plane
            modelEntity.position = SIMD3<Float>(0, 0, 0) // tweak Y if needed
            
            // Create an anchor and add the model
            let anchorEntity = AnchorEntity(plane: .horizontal)
            anchorEntity.addChild(modelEntity)
            
            arView.scene.addAnchor(anchorEntity)
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
