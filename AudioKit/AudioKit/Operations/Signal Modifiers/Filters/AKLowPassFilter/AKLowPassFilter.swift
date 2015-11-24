//
//  AKLowPassFilter.swift
//  AudioKit
//
//  Autogenerated by scripts by Aurelius Prochazka. Do not edit directly.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//

import AVFoundation

/** A first-order recursive low-pass filter with variable frequency response. */
public class AKLowPassFilter: AKOperation {

    // MARK: - Properties

    private var internalAU: AKLowPassFilterAudioUnit?
    private var token: AUParameterObserverToken?

    private var halfPowerPointParameter: AUParameter?

    /** The response curve's half-power point, in Hertz. Half power is defined as peak power / root 2. */
    public var halfPowerPoint: Float = 1000 {
        didSet {
            halfPowerPointParameter?.setValue(halfPowerPoint, originator: token!)
        }
    }

    // MARK: - Initializers

    /** Initialize this filter operation */
    public init(
        _ input: AKOperation,
        halfPowerPoint: Float = 1000) {

        self.halfPowerPoint = halfPowerPoint
        super.init()

        var description = AudioComponentDescription()
        description.componentType         = kAudioUnitType_Effect
        description.componentSubType      = 0x746f6e65 /*'tone'*/
        description.componentManufacturer = 0x41754b74 /*'AuKt'*/
        description.componentFlags        = 0
        description.componentFlagsMask    = 0

        AUAudioUnit.registerSubclass(
            AKLowPassFilterAudioUnit.self,
            asComponentDescription: description,
            name: "Local AKLowPassFilter",
            version: UInt32.max)

        AVAudioUnit.instantiateWithComponentDescription(description, options: []) {
            avAudioUnit, error in

            guard let avAudioUnitEffect = avAudioUnit else { return }

            self.output = avAudioUnitEffect
            self.internalAU = avAudioUnitEffect.AUAudioUnit as? AKLowPassFilterAudioUnit
            AKManager.sharedInstance.engine.attachNode(self.output!)
            AKManager.sharedInstance.engine.connect(input.output!, to: self.output!, format: nil)
        }

        guard let tree = internalAU?.parameterTree else { return }

        halfPowerPointParameter = tree.valueForKey("halfPowerPoint") as? AUParameter

        token = tree.tokenByAddingParameterObserver {
            address, value in

            dispatch_async(dispatch_get_main_queue()) {
                if address == self.halfPowerPointParameter!.address {
                    self.halfPowerPoint = value
                }
            }
        }

    }
}
