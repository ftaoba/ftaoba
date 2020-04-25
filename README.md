# ftaoba

ftaoba (Face Tracker AOBA) does face tracking and sends its data to any device using BlueTooth.

## BLE Peripheral Information

ftaoba BLE peripheral information.

### Identifiers

- name: `ftaoba`
- service uuid: `07B196F9-5AA0-4270-B610-8DEDA20A417C`
- characterisitic uuid: `7A051851-3ABE-4ADB-94FC-8E2021A58320`

### Notifing data

| bytes | info                             | description                                                                     |
|-------|----------------------------------|---------------------------------------------------------------------------------|
| 4     | version                          | 1                                                                               |
| 4     | float size                       | 4                                                                               |
| 8     | reserved                         | -                                                                               |
| 4     | faceAnchor.transform.columns.0.x | see: https://developer.apple.com/documentation/arkit/aranchor/2867981-transform      |
| 4     | faceAnchor.transform.columns.0.y | -                                                                               |
| 4     | faceAnchor.transform.columns.0.z | -                                                                               |
| 4     | faceAnchor.transform.columns.0.w | -                                                                               |
| 4     | faceAnchor.transform.columns.1.x | -                                                                               |
| 4     | faceAnchor.transform.columns.1.y | -                                                                               |
| 4     | faceAnchor.transform.columns.1.z | -                                                                               |
| 4     | faceAnchor.transform.columns.1.w | -                                                                               |
| 4     | faceAnchor.transform.columns.2.x | -                                                                               |
| 4     | faceAnchor.transform.columns.2.y | -                                                                               |
| 4     | faceAnchor.transform.columns.2.z | -                                                                               |
| 4     | faceAnchor.transform.columns.2.w | -                                                                               |
| 4     | faceAnchor.transform.columns.3.x | -                                                                               |
| 4     | faceAnchor.transform.columns.3.y | -                                                                               |
| 4     | faceAnchor.transform.columns.3.z | -                                                                               |
| 4     | faceAnchor.transform.columns.3.w | -                                                                               |
| 4     | eyeBlinkLeft                     | see: https://developer.apple.com/documentation/arkit/arfaceanchor/blendshapelocation |
| 4     | eyeLookDownLeft                  | -                                                                               |
| 4     | eyeLookInLeft                    | -                                                                               |
| 4     | eyeLookOutLeft                   | -                                                                               |
| 4     | eyeLookUpLeft                    | -                                                                               |
| 4     | eyeSquintLeft                    | -                                                                               |
| 4     | eyeWideLeft                      | -                                                                               |
| 4     | eyeBlinkRight                    | -                                                                               |
| 4     | eyeLookDownRight                 | -                                                                               |
| 4     | eyeLookInRight                   | -                                                                               |
| 4     | eyeLookOutRight                  | -                                                                               |
| 4     | eyeLookUpRight                   | -                                                                               |
| 4     | eyeSquintRight                   | -                                                                               |
| 4     | eyeWideRight                     | -                                                                               |
| 4     | jawForward                       | -                                                                               |
| 4     | jawLeft                          | -                                                                               |
| 4     | jawRight                         | -                                                                               |
| 4     | jawOpen                          | -                                                                               |
| 4     | mouthClose                       | -                                                                               |
| 4     | mouthFunnel                      | -                                                                               |
| 4     | mouthPucker                      | -                                                                               |
| 4     | mouthSmileLeft                   | -                                                                               |
| 4     | mouthSmileRight                  | -                                                                               |
| 4     | mouthFrownLeft                   | -                                                                               |
| 4     | mouthFrownRight                  | -                                                                               |
| 4     | mouthDimpleLeft                  | -                                                                               |
| 4     | mouthDimpleRight                 | -                                                                               |
| 4     | mouthStretchLeft                 | -                                                                               |
| 4     | mouthStretchRight                | -                                                                               |
| 4     | mouthRollLower                   | -                                                                               |
| 4     | mouthRollUpper                   | -                                                                               |
| 4     | mouthShrugLower                  | -                                                                               |
| 4     | mouthShrugUpper                  | -                                                                               |
| 4     | mouthPressLeft                   | -                                                                               |
| 4     | mouthPressRight                  | -                                                                               |
| 4     | mouthLowerDownLeft               | -                                                                               |
| 4     | mouthLowerDownRight              | -                                                                               |
| 4     | mouthUpperUpLeft                 | -                                                                               |
| 4     | mouthUpperUpRight                | -                                                                               |
| 4     | browDownLeft                     | -                                                                               |
| 4     | browDownRight                    | -                                                                               |
| 4     | browInnerUp                      | -                                                                               |
| 4     | browOuterUpLeft                  | -                                                                               |
| 4     | browOuterUpRight                 | -                                                                               |
| 4     | cheekPuff                        | -                                                                               |
| 4     | cheekSquintLeft                  | -                                                                               |
| 4     | cheekSquintRight                 | -                                                                               |
| 4     | noseSneerLeft                    | -                                                                               |
| 4     | noseSneerRight                   | -                                                                               |
| 4     | tongueOut                        | -                                                                               |
