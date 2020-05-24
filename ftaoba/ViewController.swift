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

let blendShapeLabels: [String] = [
    "eyeBlinkLeft",
    "eyeLookDownLeft",
    "eyeLookInLeft",
    "eyeLookOutLeft",
    "eyeLookUpLeft",
    "eyeSquintLeft",
    "eyeWideLeft",
    "eyeBlinkRight",
    "eyeLookDownRight",
    "eyeLookInRight",
    "eyeLookOutRight",
    "eyeLookUpRight",
    "eyeSquintRight",
    "eyeWideRight",
    "jawForward",
    "jawLeft",
    "jawRight",
    "jawOpen",
    "mouthClose",
    "mouthFunnel",
    "mouthPucker",
    "mouthSmileLeft",
    "mouthSmileRight",
    "mouthFrownLeft",
    "mouthFrownRight",
    "mouthDimpleLeft",
    "mouthDimpleRight",
    "mouthStretchLeft",
    "mouthStretchRight",
    "mouthRollLower",
    "mouthRollUpper",
    "mouthShrugLower",
    "mouthShrugUpper",
    "mouthPressLeft",
    "mouthPressRight",
    "mouthLowerDownLeft",
    "mouthLowerDownRight",
    "mouthUpperUpLeft",
    "mouthUpperUpRight",
    "browDownLeft",
    "browDownRight",
    "browInnerUp",
    "browOuterUpLeft",
    "browOuterUpRight",
    "cheekPuff",
    "cheekSquintLeft",
    "cheekSquintRight",
    "noseSneerLeft",
    "noseSneerRight",
    "tongueOut"
]

var blendShapeIsOn: [Bool] = blendShapeLabels.map { _ in false }

let transformLabels: [String] = [
    "face", "leftEye", "rightEye"
]

var transformIsOn: [Bool] = transformLabels.map { _ in false }

var customStates: [CustomState] = []

extension Float {
    var data: Data {
        var v = self
        return Data(bytes: &v, count: MemoryLayout<Float>.size)
    }
}

class ViewController: UIViewController, ARSessionDelegate {
    
    // MARK: Properties
    
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var cameraToggleButton: UIButton!
    @IBOutlet weak var faceInfoView: UITextView!
    @IBOutlet weak var faceInfoButton: UIButton!
    private var virtualFaceNode = SCNNode()
    private let facePeripheral = FacePeripheral()
    private var orinialSceneContents: Any?
    private var isFacePreviewEnabled: Bool! {
        didSet {
            updateFacePreview()
        }
    }
    private var isFaceInfoViewEnabled: Bool! {
        didSet {
            updateFaceInfoView()
        }
    }
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.automaticallyUpdatesLighting = true

        let maskGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        maskGeometry.firstMaterial?.fillMode = .lines
        maskGeometry.firstMaterial?.lightingModel = .physicallyBased
        virtualFaceNode.geometry = maskGeometry
        
        isFacePreviewEnabled = true
        isFaceInfoViewEnabled = false
        
        faceInfoView.text = ""
        faceInfoView.font = UIFont.monospacedSystemFont(ofSize: 10, weight: .regular)
        faceInfoView.contentInset = UIEdgeInsets(top: 64, left: 64, bottom: 64, right: 64)
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
    
    private func updateFacePreview() {
        cameraToggleButton.isSelected = isFacePreviewEnabled
        if isFacePreviewEnabled {
            sceneView.scene.background.contents = orinialSceneContents
            resetTracking()
        } else {
            if orinialSceneContents == nil {
                orinialSceneContents = sceneView.scene.background.contents
            }
            sceneView.scene.background.contents = UIColor.black
        }
    }
    
    private func updateFaceInfoView() {
        faceInfoButton.isSelected = isFaceInfoViewEnabled
        faceInfoView.isHidden = !isFaceInfoViewEnabled
    }
    
    // MARK: Actions
    @IBAction func toggleFacePreviewEnabled(_ sender: UIButton) {
        isFacePreviewEnabled = !isFacePreviewEnabled
    }
    
    @IBAction func toggleFaceInfoEnabled(_ sender: UIButton) {
        isFaceInfoViewEnabled = !isFaceInfoViewEnabled
    }
    
    @IBAction func openGithubLink(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://github.com/ukyo/ftaoba")!)
    }
}

extension ViewController: ARSCNViewDelegate {
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else {
            return
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
        
        var text = ""
        
        for (i, k) in blendShapeKeys.enumerated() {
            let v = faceAnchor.blendShapes[k]?.floatValue
            data.replaceSubrange(offset..<offset+floatSize, with: (v?.data) ?? Float(0).data)
            offset += floatSize
            if isFaceInfoViewEnabled {
                text += "\(blendShapeLabels[i]): \(v!)\n"
            }
        }
        
        if isFaceInfoViewEnabled {
            DispatchQueue.main.async {
                self.faceInfoView.text = text
            }
        }

        facePeripheral.notify(data)
    }
}
