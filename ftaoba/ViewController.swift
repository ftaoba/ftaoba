//
//  ViewController.swift
//  ftaoba
//
//  Created by ukyo on 2020/04/18.
//  Copyright © 2020 ukyo. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import os.log

let blendShapeKeys: [ARFaceAnchor.BlendShapeLocation] = [
    .eyeBlinkLeft,
    .eyeLookDownLeft,
    .eyeLookInLeft,
    .eyeLookOutLeft,
    .eyeLookUpLeft,
    .eyeSquintLeft,
    .eyeWideLeft,
    .eyeBlinkRight,
    .eyeLookDownRight,
    .eyeLookInRight,
    .eyeLookOutRight,
    .eyeLookUpRight,
    .eyeSquintRight,
    .eyeWideRight,
    .jawForward,
    .jawLeft,
    .jawRight,
    .jawOpen,
    .mouthClose,
    .mouthFunnel,
    .mouthPucker,
    .mouthSmileLeft,
    .mouthSmileRight,
    .mouthFrownLeft,
    .mouthFrownRight,
    .mouthDimpleLeft,
    .mouthDimpleRight,
    .mouthStretchLeft,
    .mouthStretchRight,
    .mouthRollLower,
    .mouthRollUpper,
    .mouthShrugLower,
    .mouthShrugUpper,
    .mouthPressLeft,
    .mouthPressRight,
    .mouthLowerDownLeft,
    .mouthLowerDownRight,
    .mouthUpperUpLeft,
    .mouthUpperUpRight,
    .browDownLeft,
    .browDownRight,
    .browInnerUp,
    .browOuterUpLeft,
    .browOuterUpRight,
    .cheekPuff,
    .cheekSquintLeft,
    .cheekSquintRight,
    .noseSneerLeft,
    .noseSneerRight,
    .tongueOut
]

extension Float {
    var data: Data {
        var v = self
        return Data(bytes: &v, count: MemoryLayout<Float>.size)
    }
}

class ViewController: UIViewController, ARSessionDelegate {
    
    // MARK: Properties
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var connectingImage: UIImageView!
    @IBOutlet weak var trackingImage: UIImageView!
    private var virtualFaceNode = SCNNode()
    private let facePeripheral = FacePeripheral()
    private var orinialSceneContents: Any?
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.scene.background.contents = UIColor.systemBackground

        let maskGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        maskGeometry.firstMaterial?.fillMode = .lines
        maskGeometry.firstMaterial?.lightingModel = .physicallyBased
        virtualFaceNode.geometry = maskGeometry
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard ARFaceTrackingConfiguration.isSupported else {
            let unsupportedAlert = UIAlertController(title: "Unsupported Device", message: "ARKit face tracking requires a device with a TrueDepth front-facing camera.", preferredStyle: .alert)
            unsupportedAlert.addAction(UIAlertAction(title: "OK", style: .default))
            present(unsupportedAlert, animated: true, completion: nil)
            return
        }
        
        UIApplication.shared.isIdleTimerDisabled = true
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    // MARK: Private Methods
    
    private func resetTracking() {
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
        }
        
        DispatchQueue.main.async {
            self.trackingImage.isHidden = !faceAnchor.isTracked
            self.connectingImage.isHidden = !self.facePeripheral.isConnecting
        }

        let geometry = virtualFaceNode.geometry as! ARSCNFaceGeometry
        geometry.update(from: faceAnchor.geometry)

        let floatSize = MemoryLayout<Float>.size
        var data = Data(count: 8 + (16 + blendShapeKeys.count) * floatSize)
        data.replaceSubrange(0..<2, with: [1, UInt8(floatSize)])
        var offset = 8
        [
            faceAnchor.transform.columns.0,
            faceAnchor.transform.columns.1,
            faceAnchor.transform.columns.2,
            faceAnchor.transform.columns.3
        ].forEach { col in
            [col.x, col.y, col.z, col.w].forEach { r in
                data.replaceSubrange(offset..<offset+floatSize, with: r.data)
                offset += floatSize
            }
        }

        for (_, k) in blendShapeKeys.enumerated() {
            let v = faceAnchor.blendShapes[k]?.floatValue
            data.replaceSubrange(offset..<offset+floatSize, with: (v?.data) ?? Float(0).data)
            offset += floatSize
        }

        facePeripheral.notify(data)
    }
}
