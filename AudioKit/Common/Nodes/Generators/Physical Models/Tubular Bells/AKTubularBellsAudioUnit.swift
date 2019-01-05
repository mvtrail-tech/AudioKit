//
//  AKTubularBellsAudioUnit.swift
//  AudioKit
//
//  Created by Aurelius Prochazka on 12/22/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import AVFoundation

public class AKTubularBellsAudioUnit: AKGeneratorAudioUnitBase {

    func setParameter(_ address: AKTubularBellsParameter, value: Double) {
        setParameterWithAddress(address.rawValue, value: Float(value))
    }

    func setParameterImmediately(_ address: AKTubularBellsParameter, value: Double) {
        setParameterImmediatelyWithAddress(address.rawValue, value: Float(value))
    }

    var frequency: Double = 440 {
        didSet { setParameter(.frequency, value: frequency) }
    }
    var amplitude: Double = 1 {
        didSet { setParameter(.amplitude, value: amplitude) }
    }

    var rampDuration: Double = 0.0 {
        didSet { setParameter(.rampDuration, value: rampDuration) }
    }

    public override func initDSP(withSampleRate sampleRate: Double,
                                 channelCount count: AVAudioChannelCount) -> AKDSPRef {
        return createTubularBellsDSP(Int32(count), sampleRate)
    }

    public override init(componentDescription: AudioComponentDescription,
                         options: AudioComponentInstantiationOptions = []) throws {
        try super.init(componentDescription: componentDescription, options: options)

        let frequency = AUParameterTree.createParameter(
            withIdentifier: "frequency",
            name: "Frequency (Hz)",
            address: 0,
            min: 0,
            max: 20_000,
            unit: .hertz,
            unitName: nil,
            flags: .default,
            valueStrings: nil,
            dependentParameters: nil
        )
        let amplitude = AUParameterTree.createParameter(
            withIdentifier: "amplitude",
            name: "Amplitude",
            address: AUParameterAddress(1),
            min: 0,
            max: 10,
            unit: .generic,
            unitName: nil,
            flags: .default,
            valueStrings: nil,
            dependentParameters: nil
        )
        setParameterTree(AUParameterTree.createTree(withChildren: [frequency, amplitude]))
        frequency.value = 110
        amplitude.value = 0.5
    }

    public override var canProcessInPlace: Bool { return true }

}
