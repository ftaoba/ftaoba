//
//  TransformVisualization.swift
//  blueface
//
//  Created by ukyo on 2020/04/18.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class TransformVisualization: NSObject {
    var contentNode: SCNNode?
    var rightEyeNode = SCNReferenceNode()

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard anchor is ARFaceAnchor else {
            return nil
        }
        contentNode = SCNReferenceNode()
        self.addTransformNodes()
        return contentNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
        }
        rightEyeNode.simdTransform = faceAnchor.rightEyeTransform
    }
    
    func addTransformNodes() {
        guard let anchorNode = contentNode else {
            return
        }
        anchorNode.simdPivot = float4x4(diagonal: SIMD4<Float>(3, 3, 3, 1))
        anchorNode.addChildNode(rightEyeNode)
    }
}
