// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKFlangerTests: XCTestCase {

    func testParameters() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKFlanger(input,
                          frequency: 1.1,
                          depth: 0.8,
                          feedback: 0.7,
                          dryWetMix: 0.9)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testDefault() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKFlanger(input)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testDepth() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKFlanger(input, depth: 0.88)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testDryWetMix() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKFlanger(input, dryWetMix: 0.55)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testFeedback() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKFlanger(input, feedback: 0.77)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testFrequency() {
        let engine = AKEngine()
        let input = Oscillator()
        engine.output = AKFlanger(input, frequency: 1.11)
        input.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }
}
