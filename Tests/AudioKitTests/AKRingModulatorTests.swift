// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKRingModulatorTests: XCTestCase {

    func testDefault() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKRingModulator(input)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }
}
