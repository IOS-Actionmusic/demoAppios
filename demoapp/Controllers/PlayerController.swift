//
//  PlayerController.swift
//  demoapp
//
//  Created by Jason Sekhon on 2017-09-22.
//  Copyright © 2017 Jason Sekhon. All rights reserved.
//

import UIKit
import AVKit
import CoreAudioKit
import MediaPlayer

class PlayerController: UIViewController {
    @IBOutlet weak var nowPlayingLabel: UILabel!
    @IBOutlet weak var Volume: UISlider!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var albumImage: UIImageView!
    // Instantiate a new music player
    let myMediaPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
    let volumeSlider = (MPVolumeView().subviews.filter { NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as! UISlider)
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMediaPlayer.setQueue(with: MPMediaQuery.songs())
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        updateSlider()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        myMediaPlayer.stop()
    }
    
    @objc func updateSlider(){
        Volume.setValue(volumeSlider.value, animated: true)
    }
    
    func updateSongTitle(){
        nowPlayingLabel.text = (myMediaPlayer.nowPlayingItem?.title)!
        artistLabel.text = (myMediaPlayer.nowPlayingItem?.artist!)!
        albumImage.image = myMediaPlayer.nowPlayingItem?.artwork?.image(at: albumImage.intrinsicContentSize)
    }
    
    @IBAction func sliderVolume(_ sender: AnyObject) {
        volumeSlider.setValue(sender.value, animated: false)
    }
    
    @IBAction func playOrPause(_ sender: Any) {
        print("playorpause")
        print(myMediaPlayer.playbackState.rawValue)
        if (myMediaPlayer.playbackState.rawValue == 1){
            myMediaPlayer.pause()
            playBtn.setTitle("Play", for: .normal)
        } else if (myMediaPlayer.playbackState.rawValue == 2 || myMediaPlayer.playbackState.rawValue == 0){
            myMediaPlayer.play()
            playBtn.setTitle("Pause", for: .normal)
        }
        updateSongTitle()
    }
    
    @IBAction func next(_ sender: Any) {
        myMediaPlayer.skipToNextItem()
        updateSongTitle()
    }
    
    @IBAction func prev(_ sender: Any) {
        myMediaPlayer.skipToPreviousItem()
        updateSongTitle()
    }
    
}
