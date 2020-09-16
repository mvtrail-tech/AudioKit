// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKLowShelfParametricEqualizerFilterTests: XCTestCase {

    func testCornerFrequency() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKLowShelfParametricEqualizerFilter(input, cornerFrequency: 500)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testDefault() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKLowShelfParametricEqualizerFilter(input)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testGain() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKLowShelfParametricEqualizerFilter(input, gain: 2)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testParameters() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKLowShelfParametricEqualizerFilter(input, cornerFrequency: 500, gain: 2, q: 1.414)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testQ() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKLowShelfParametricEqualizerFilter(input, q: 1.415)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }
}
