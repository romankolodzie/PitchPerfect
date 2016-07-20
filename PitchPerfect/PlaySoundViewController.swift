//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Roman Kolodzie on 2/24/16.
//  Copyright © 2016 RomanKolodzie. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer! = nil
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var recievedAudio: RecordedAudio!

    override func viewDidLoad() {
        super.viewDidLoad()

        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recievedAudio.filePathURL)
        
        try! audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathURL, fileTypeHint: nil)
        audioPlayer.enableRate = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetAudio () {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
    func playAudioWithVariableRate(rate: Float){
        resetAudio()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithEffect(effect: AVAudioUnit){
        resetAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        audioEngine.attachNode(effect)
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }

    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        let reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(AVAudioUnitReverbPreset.LargeChamber)
        reverbEffect.wetDryMix = 50.0
        playAudioWithEffect(reverbEffect)
    }
    
    @IBAction func playAudioWithEcho(sender: UIButton) {
        let echoEffect = AVAudioUnitDelay()
        echoEffect.wetDryMix = 30.0
        echoEffect.delayTime = 0.2
        echoEffect.feedback = 25
        playAudioWithEffect(echoEffect)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = -1000
        playAudioWithEffect(pitchEffect)
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        let pitchEffect = AVAudioUnitTimePitch()
        pitchEffect.pitch = 1000
        playAudioWithEffect(pitchEffect)
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        resetAudio()
    }
}
